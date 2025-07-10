SELECT 
    db.name AS database_name,
    mf.name AS file_logical_name,
    mf.type_desc AS file_type,
    mf.physical_name,
    CONVERT(DECIMAL(18,2), mf.size * 8 / 1024.0) AS size_mb,
    CONVERT(DECIMAL(18,2), mf.size * 8 / 1024.0 / 1024.0) AS size_gb
FROM sys.master_files mf
JOIN sys.databases db ON db.database_id = mf.database_id
WHERE db.database_id > 4 
ORDER BY db.name, mf.type_desc;