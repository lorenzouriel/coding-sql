DECLARE 
	@FTPPath varchar(1024) = '/backup/DIFF/',
	@BakName  varchar(1024),
	@RemoteFolderPath varchar(1024)

SELECT TOP 1 
    --physical_device_name,
    @BakName = SUBSTRING(physical_device_name, LEN(physical_device_name) - CHARINDEX('\', REVERSE(physical_device_name)) + 2, LEN(physical_device_name))
FROM msdb.dbo.backupmediafamily
WHERE media_set_id = (
    SELECT TOP 1 media_set_id
    FROM msdb.dbo.backupset
    WHERE type = 'I' -- I stands for database backup, adjust if needed
    ORDER BY backup_finish_date DESC
);

SET @RemoteFolderPath = @FTPPath + @BakName

SELECT @RemoteFolderPath AS [RemoteFolderPath], @BakName AS [BackupName]