DBCC SHRINKDATABASE (faturamento, 10);


SELECT name AS [Logical Name], physical_name AS [Physical Name], type_desc AS [File Type]
FROM sys.master_files
WHERE database_id = DB_ID(N'SSISDB');


DBCC SHRINKFILE (log, 10);