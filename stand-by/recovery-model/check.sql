SELECT 
    name AS DatabaseName,
    recovery_model_desc AS RecoveryModel
FROM 
    sys.databases
WHERE 
    name = 'YourDatabaseName';  -- replace with your actual DB name


SELECT 
    name AS DatabaseName,
    recovery_model_desc AS RecoveryModel
FROM 
    sys.databases;