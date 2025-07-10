SELECT 
    SUM(CAST(size AS BIGINT)) * 8 / 1024 AS total_size_mb,
    SUM(CAST(size AS BIGINT)) * 8 / 1024.0 / 1024.0 AS total_size_gb
FROM sys.master_files;