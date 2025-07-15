EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE;

SELECT 
	*
FROM msdb.dbo.sysmail_profile;