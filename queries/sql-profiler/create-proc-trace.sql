-- Cria��o da Procedure
USE [your_db]
GO

ALTER PROCEDURE [dbo].[AutomaticallyProfiler]

     @RunTime int = 1 -- Duration of the trace in minutes

AS-- Create a Queue

DECLARE @rc int
DECLARE @TraceID int
DECLARE @maxfilesize bigint

-- Generate File Names based on prefix and time stamp
-- Specify Max File Size and Location
DECLARE @Now datetime
DECLARE @StopTime DateTime
DECLARE @FQFileName Nvarchar(100)
DECLARE @FileStamp Nvarchar(25)

SET @Now = GETDATE()
SET @StopTime = DATEADD(MI, @RunTime, @Now)
SET @FQFileName = 'C:\Profiler\TraceProfiler_'
SET @FileStamp =
    CAST(DATEPART(YEAR, GETDATE()) AS NVARCHAR) +
    RIGHT('0' + CAST(DATEPART(MONTH, GETDATE()) AS NVARCHAR), 2) +
    RIGHT('0' + CAST(DATEPART(DAY, GETDATE()) AS NVARCHAR), 2)

SET @FQFileName = @FQFileName + @FileStamp
SET @maxfilesize = 500

EXEC @rc = sp_trace_create @TraceID OUTPUT, 0, @FQFileName, @maxfilesize, @StopTime
IF (@rc != 0) GOTO error

-- Set the events
DECLARE @on BIT
SET @on = 1

-- Configurar eventos de rastreamento (Aqui voc� pode alterar conforme o que deseja visualizar)

EXEC sp_trace_setevent @TraceID, 10, 1, @on
EXEC sp_trace_setevent @TraceID, 10, 12, @on
EXEC sp_trace_setevent @TraceID, 10, 13, @on
EXEC sp_trace_setevent @TraceID, 12, 1, @on
EXEC sp_trace_setevent @TraceID, 12, 12, @on
EXEC sp_trace_setevent @TraceID, 12, 13, @on


-- Set the Filters
DECLARE @intfilter int
DECLARE @bigintfilter bigint

SET @intfilter = 50
EXEC sp_trace_setfilter @TraceID, 12, 0, 4, @intfilter
EXEC sp_trace_setfilter @TraceID, 35, 0, 7, N'Master'

-- Set the trace status to start
EXEC sp_trace_setstatus @TraceID, 1
-- display trace id for future references
      SELECT TraceID=@TraceID
      goto finish
      error:

      SELECT ErrorCode=@rc
      finish:
Go


-- Executa a Procedure
USE [data_mart]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[AutomaticallyProfiler]

SELECT	'Return Value' = @return_value

GO



-- Realiza a Consulta para encontrar valores com a dura��o maior que 30 segundos
DECLARE @FQFileName NVARCHAR(100)
DECLARE @FileStamp NVARCHAR(25)

SET @FQFileName = 'C:\Profiler\TraceProfiler_'

SET @FileStamp =
    CAST(DATEPART(YEAR, GETDATE()) AS NVARCHAR) +
    RIGHT('0' + CAST(DATEPART(MONTH, GETDATE()) AS NVARCHAR), 2) +
    RIGHT('0' + CAST(DATEPART(DAY, GETDATE()) AS NVARCHAR), 2) 

SET @FQFileName = @FQFileName + @FileStamp + '.trc'

DECLARE @DurationCount INT

SELECT @DurationCount = ISNULL(COUNT(Duration), 0)
FROM fn_trace_gettable(@FQFileName, 1)
WHERE [Duration] > 30000000

IF @DurationCount > 0 OR @DurationCount <> 0
BEGIN
    -- Lan�ar um erro personalizado
    -- THROW 50001, 'O valor do WHERE � maior ou diferente de 0.', 1

    -- Lan�ar um erro usando RAISERROR
    RAISERROR('Existem consultas que levaram mais de 30 segundos', 16, 1)
END



---- Liberar comandos cmd_shell
--sp_configure 'show advanced options', 1;
--GO
--RECONFIGURE;
--GO
--sp_configure 'xp_cmdshell', 1;
--GO
--RECONFIGURE;
--GO

---- Verifica se foi habilitado
--sp_configure 'xp_cmdshell';
--GO



-- Deleta o arquivo criado na pasta (Se n�o houver consultas maiores que 30 segundos)
DECLARE @FilePath NVARCHAR(100)
DECLARE @FileName NVARCHAR(100)

SET @FilePath = 'C:\Profiler\'
SET @FileName = 'TraceProfiler_'

SET @FileName =
    @FileName +
    CAST(DATEPART(YEAR, GETDATE()) AS NVARCHAR) +
    RIGHT('0' + CAST(DATEPART(MONTH, GETDATE()) AS NVARCHAR), 2) +
    RIGHT('0' + CAST(DATEPART(DAY, GETDATE()) AS NVARCHAR), 2) +
    '.trc'

DECLARE @Cmd NVARCHAR(200)
SET @Cmd = 'DEL "' + @FilePath + @FileName + '"'

EXEC xp_cmdshell @Cmd