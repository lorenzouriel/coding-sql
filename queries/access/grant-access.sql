USE [dev_os];
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'dev')
BEGIN
    CREATE USER [dev] FOR LOGIN [dev];
END
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO [dev];
GO