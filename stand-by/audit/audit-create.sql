-- Create an audit object (stores logs)
CREATE SERVER AUDIT Audit_TagUsers
TO FILE (FILEPATH = 'C:\AuditLogs\', MAXSIZE = 10MB, ROLLOVER = ON);

-- Enable the audit
ALTER SERVER AUDIT [audit_server] WITH (STATE = ON);

USE [database];
GO

CREATE DATABASE AUDIT SPECIFICATION [audit_users_changes]
FOR SERVER AUDIT [audit_server]
ADD (INSERT, UPDATE, DELETE ON [dbo].[users] BY public);
GO

ALTER DATABASE AUDIT SPECIFICATION [audit_users_changes]
WITH (STATE = ON);
