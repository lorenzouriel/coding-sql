DECLARE @ArquivosLog TABLE ( LogNumber INT, StartDate DATETIME, SizeInBytes INT )
DECLARE @Dados TABLE ( [LogDate] datetime, [ProcessInfo] nvarchar(12), [Text] nvarchar(3999) ) 
INSERT INTO @ArquivosLog 
EXEC sys.xp_enumerrorlogs 1
 
 
DECLARE 
    @Contador INT = 0, 
    @Total INT = (SELECT COUNT(*) FROM @ArquivosLog)
 
WHILE(@Contador < @Total)
BEGIN
 
    INSERT INTO @Dados
    EXEC sys.sp_readerrorlog @Contador, 1, 'login failed'
    
    SET @Contador += 1
 
END
 
 
SELECT
   MIN(LogDate) AS Dt_Menor_Ocorrencia,
   MAX(LogDate) AS Dt_Maior_Ocorrencia,
   SUBSTRING([Text], 1, IIF(CHARINDEX('[', [Text]) = 0, LEN([Text]), CHARINDEX('[', [Text]) - 1))  AS Texto,
   COUNT(DISTINCT [Text]) AS Quantidade
FROM
   @Dados
GROUP BY
   SUBSTRING([Text], 1, IIF(CHARINDEX('[', [Text]) = 0, LEN([Text]), CHARINDEX('[', [Text]) - 1))
ORDER BY
   4 DESC