/*==========================================================
  1. CREATE AUDIT OBJECT
     - Stores logs in a secure, access-restricted folder.
==========================================================*/
CREATE SERVER AUDIT FinPulseComplianceAudit
TO FILE (
    FILEPATH = 'E:\FinPulse_AuditLogs\', -- Must exist & have restricted access
    MAXSIZE = 500 MB,
    MAX_ROLLOVER_FILES = 50  -- ~90 days retention before rotation
)
WITH (ON_FAILURE = CONTINUE);

ALTER SERVER AUDIT FinPulseComplianceAudit
WITH (STATE = ON);


/*==========================================================
  2. CREATE DATABASE AUDIT SPECIFICATION
     - Tracks SELECT, UPDATE, DELETE on sensitive CustomerAccounts table.
==========================================================*/
USE Transactions;
GO

CREATE DATABASE AUDIT SPECIFICATION AuditCustomerAccountAccess
FOR SERVER AUDIT FinPulseComplianceAudit
ADD (SELECT, UPDATE, DELETE ON dbo.CustomerAccounts BY PUBLIC)
WITH (STATE = ON);


/*==========================================================
  3. CREATE SERVER AUDIT SPECIFICATION
     - Tracks failed login attempts across the SQL Server instance.
==========================================================*/
CREATE SERVER AUDIT SPECIFICATION AuditFailedLogins
FOR SERVER AUDIT FinPulseComplianceAudit
ADD (FAILED_LOGIN_GROUP)
WITH (STATE = ON);
GO
