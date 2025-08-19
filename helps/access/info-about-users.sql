-- Informa��es b�sicas dos usu�rios
exec sp_helplogins

select name, accdate 
from sys.syslogins

SELECT *
  FROM [sys].[sql_logins]

-- Query para verificar acessos concedidos a usu�rios
SELECT
   S.name,
   S.loginname,
   S.password,
   l.sid,
   l.is_disabled,
   S.createdate,
   S.denylogin,
   S.hasaccess,
   S.isntname,
   S.isntgroup,
   S.isntuser,
   S.sysadmin,
   S.securityadmin,
   S.serveradmin,
   S.processadmin,
   S.diskadmin,
   S.dbcreator,
   S.bulkadmin
FROM [sys].[syslogins] S
 LEFT JOIN
  [sys].[sql_logins] L
 ON
 S.sid = L.sid

-- Usu�rio e �ltimo login
SELECT 
	login_name AS [Login], 
    MAX(login_time) AS [Last Login Time] 
FROM sys.dm_exec_sessions 
GROUP BY login_name
-------------------------------------------------------------------------------
 
IF (OBJECT_ID('tempdb..#Arquivos_Log') IS NOT NULL) DROP TABLE #Arquivos_Log
CREATE TABLE #Arquivos_Log ( 
    [idLog] INT, 
    [dtLog] NVARCHAR(30) COLLATE SQL_Latin1_General_CP1_CI_AI, 
    [tamanhoLog] INT 
)
 
IF (OBJECT_ID('tempdb..#Dados') IS NOT NULL) DROP TABLE #Dados
CREATE TABLE #Dados (
    [LogDate] DATETIME, 
    [ProcessInfo] NVARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AI, 
    [Text] NVARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AI,
    [User] AS (SUBSTRING(REPLACE([Text], 'Login succeeded for user ''', ''), 1, CHARINDEX('''', REPLACE([Text], 'Login succeeded for user ''', '')) - 1))
)
 
INSERT INTO #Arquivos_Log
EXEC sys.sp_enumerrorlogs
 
DECLARE
    @Contador INT = 0,
    @Total INT = (SELECT COUNT(*) FROM #Arquivos_Log)
    
WHILE(@Contador < @Total)
BEGIN
    
    INSERT INTO #Dados (LogDate, ProcessInfo, [Text]) 
    EXEC master.dbo.xp_readerrorlog @Contador, 1, N'Login succeeded for user', NULL, NULL, NULL
 
    SET @Contador += 1
    
END 
 
IF (OBJECT_ID('tempdb..#UltimoLogin') IS NOT NULL) DROP TABLE #UltimoLogin
CREATE TABLE #UltimoLogin (
    [User] VARCHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL,
    LogDate DATETIME NOT NULL
) 
INSERT INTO #UltimoLogin
SELECT 
    [User], 
    MAX(LogDate) AS LogDate
FROM
    #Dados
GROUP BY
    [User]
 
-- Cria a tabela, se n�o existir
IF (OBJECT_ID('dbo.LastLogin') IS NULL)
BEGIN
    
    -- DROP TABLE dbo.LastLogin
    CREATE TABLE dbo.LastLogin (
        Username VARCHAR(128) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL,
        CreateDate DATETIME,
        LastLogin DATETIME NULL,
        DaysSinceLastLogin AS (DATEDIFF(DAY, ISNULL(LastLogin, CreateDate), CONVERT(DATE, GETDATE())))
    )
 
END

-- Insere os logins criados na inst�ncia
INSERT INTO dbo.LastLogin (Username, CreateDate)
SELECT
    [name],
    create_date
FROM
    sys.server_principals A
    LEFT JOIN dbo.LastLogin B ON A.[name] COLLATE SQL_Latin1_General_CP1_CI_AI = B.Username
WHERE
    is_fixed_role = 0
    AND [name] NOT LIKE 'NT %'
    AND [name] NOT LIKE '##%'
    AND B.Username IS NULL
    AND A.[type] IN ('S', 'U')

-- Atualiza a tabela de hist�rico com os dados atuais
UPDATE A
SET
    A.LastLogin = B.LogDate
FROM
    dbo.LastLogin A
    JOIN #UltimoLogin B ON A.Username = B.[User]
WHERE
    ISNULL(A.LastLogin, '1900-01-01') <> B.LogDate
 
SELECT * 
FROM dbo.LastLogin
