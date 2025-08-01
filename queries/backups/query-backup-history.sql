SELECT 
    bs.database_name,
    MAX(bs.backup_finish_date) AS last_backup_finish,
    bmf.physical_device_name,
    bs.type AS backup_type,
    CASE bs.type
        WHEN 'D' THEN 'Full'
        WHEN 'I' THEN 'Differential'
        WHEN 'L' THEN 'Transaction Log'
        ELSE bs.type
    END AS backup_type_desc
FROM msdb.dbo.backupset bs
LEFT JOIN msdb.dbo.backupmediafamily bmf 
    ON bs.media_set_id = bmf.media_set_id
WHERE [database_name] = 'geotracker.data'
GROUP BY bs.database_name, bmf.physical_device_name, bs.type
ORDER BY bs.database_name, last_backup_finish DESC;