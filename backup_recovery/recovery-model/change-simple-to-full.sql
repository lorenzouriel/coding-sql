-- What You Must Do After Switching
-- Run this to change to Full:
ALTER DATABASE [YourDatabaseName] SET RECOVERY FULL;

-- Immediately take a full backup:
BACKUP DATABASE [YourDatabaseName] TO DISK = 'C:\Backups\YourDatabaseName.bak';

-- This backup "activates" the full recovery model. Without it, transaction log backups will fail.
-- Set up transaction log backups regularly:

BACKUP LOG [YourDatabaseName] TO DISK = 'C:\Backups\YourDatabaseName_Log.trn';

-- Run every 5–15 minutes, or per your RPO.
-- This prevents uncontrolled transaction log growth.