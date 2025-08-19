-- Grant SQL Server Agent Reader Role: The SQLAgentReaderRole allows users to view the SQL Server Agent jobs and their status. However, they won’t be able to modify or start/stop the jobs.
USE [msdb];
GO
EXEC sp_addrolemember N'SQLAgentReaderRole', N'username';
GO


-- Grant SQL Server Agent Operator Role: The SQLAgentOperatorRole allows users to view and execute jobs, as well as read logs.
USE [msdb];
GO
EXEC sp_addrolemember N'SQLAgentOperatorRole', N'username';
GO


-- Grant SQL Server Agent User Role: The SQLAgentUserRole allows users to create and modify their own jobs but doesn’t give them control over other users' jobs.
USE [msdb];
GO
EXEC sp_addrolemember N'SQLAgentUserRole', N'username';
GO