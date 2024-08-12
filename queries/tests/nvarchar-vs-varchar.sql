USE [test_field]
GO

CREATE TABLE [nvarchar] (
[id] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CS_AS NOT NULL
)
GO

CREATE TABLE [varchar] (
[id] [varchar](5) COLLATE SQL_Latin1_General_CP1_CS_AS NOT NULL
)

INSERT INTO [nvarchar] 
VALUES
('Y2bYE'),
('Y2byE')
GO 

INSERT INTO [varchar] 
VALUES
('Y2bYE'),
('Y2byE')


SELECT 
	*
FROM [nvarchar]
WHERE [id] = 'Y2byE'


SELECT 
	*
FROM [varchar]
WHERE [id] = 'Y2byE'