USE [master];
GO
DENY VIEW ANY DATABASE TO [lorenzo.dev]

USE [master];
GO
ALTER AUTHORIZATION ON DATABASE::[database] TO [lorenzo.dev]
GO