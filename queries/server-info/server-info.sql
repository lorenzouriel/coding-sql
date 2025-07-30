SELECT 
    SERVERPROPERTY('InstanceName') AS InstanceName,
    SERVERPROPERTY('Edition') AS Edition,
    SERVERPROPERTY('ProductVersion') AS Version,
    SERVERPROPERTY('InstallDate') AS InstallDate,
    SERVERPROPERTY('ServerName') AS ServerName,
    SERVERPROPERTY('MachineName') AS MachineName,
    SERVERPROPERTY('SqlBinRoot') AS SqlBinRoot

SELECT SERVERPROPERTY('InstanceDefaultDataPath') AS DefaultDataPath,
       SERVERPROPERTY('InstanceDefaultLogPath') AS DefaultLogPath;
