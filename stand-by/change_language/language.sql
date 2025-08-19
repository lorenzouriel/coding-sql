SELECT * FROM sys.syslanguages;
 
SELECT @@LANGUAGE

SELECT name, default_language_name   
FROM sys.server_principals   
WHERE type IN ('S', 'U'); -- S for SQL Server logins, U for Windows logins  