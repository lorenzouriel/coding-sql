-- run the following code to show the advanced options
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

-- Check the Agent XPs Current Setting
EXEC SP_CONFIGURE 'Agent XPs';

--Enable Agent XPs
EXEC SP_CONFIGURE 'Agent XPs', 1;
GO
RECONFIGURE;
GO

-- Re-check the Agent XPs Current Setting
EXEC SP_CONFIGURE 'Agent XPs';

-- Hide Advanced Options
EXEC sp_configure 'show advanced options', 0;
GO
RECONFIGURE;
GO