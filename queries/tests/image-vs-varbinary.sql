USE [media]
GO

CREATE TABLE [dbo].[attachment_varbinary](
	[id] [nvarchar](5) NOT NULL,
	[attachment] [varbinary](max) NULL,
)
GO

CREATE TABLE [dbo].[attachment_image](
	[id] [nvarchar](5) NOT NULL PRIMARY KEY,
	[attachment] [image] NULL
)

