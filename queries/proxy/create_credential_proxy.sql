USE master;
GO
CREATE CREDENTIAL [ProxyCredentialAdmin]
WITH IDENTITY = 'WIN-NSVRTRFU2EL\lorenzo.uriel',  -- local administrator account
SECRET = 'Lukaku@2022';
GO

USE msdb;
GO
EXEC dbo.sp_add_proxy  
    @proxy_name = 'AdminProxy',
    @credential_name = 'ProxyCredentialAdmin',
    @enabled = 1;
GO
