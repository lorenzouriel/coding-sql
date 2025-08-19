USE [master];
GO
GRANT VIEW [dev_os] DATABASE TO [dev]; 

USE [master];
GO
ALTER AUTHORIZATION ON DATABASE::[dev_os] TO [dev];
GO