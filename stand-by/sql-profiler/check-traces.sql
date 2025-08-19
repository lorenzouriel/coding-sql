--see if trace is running
select * from sys.traces
--Mark Trace Store Proc startup option True
EXEC sp_procoption 'StoreProcName', 'startup', 'true';
--Verify start option value is 1
USE MASTER
GO
SELECT VALUE, VALUE_IN_USE, DESCRIPTION
FROM SYS.CONFIGURATIONS
WHERE NAME = 'scan for startup procs'
GO