SELECT 
    r.destination_database_name,
    r.restore_date AS restore_completed_at,
    b.backup_start_date,
    b.backup_finish_date,
    DATEDIFF(SECOND, b.backup_start_date, b.backup_finish_date) AS backup_duration_seconds,
    b.backup_size / 1024 / 1024 AS backup_size_MB
FROM msdb.dbo.restorehistory r
JOIN msdb.dbo.backupset b ON r.backup_set_id = b.backup_set_id
ORDER BY r.restore_date DESC;

-- database <>	start: 2025-07-11 18:16:15.893 - end: 2025-07-12 23:48:08.670

EXEC sp_readerrorlog 0, 1, N'Restore', N'MB/sec';

-- Check logs
EXEC xp_readerrorlog 0, 1, N'geotracker.aux';