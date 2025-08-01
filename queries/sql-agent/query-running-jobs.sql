SELECT 
    j.name AS job_name,
    ja.start_execution_date
FROM msdb.dbo.sysjobactivity ja
JOIN msdb.dbo.sysjobs j ON ja.job_id = j.job_id
WHERE ja.stop_execution_date IS NULL
  AND ja.start_execution_date IS NOT NULL;
  

EXEC msdb.dbo.sp_help_job 
    @execution_status = 1; -- 1 = Executing


USE msdb;
GO

SELECT 
    j.job_id,
    j.name AS job_name,
    ja.start_execution_date,
    ja.stop_execution_date,
    CASE 
        WHEN ja.start_execution_date IS NOT NULL AND ja.stop_execution_date IS NULL THEN 'Running'
        ELSE 'Not Running'
    END AS job_status
FROM msdb.dbo.sysjobactivity ja
INNER JOIN msdb.dbo.sysjobs j ON ja.job_id = j.job_id
WHERE j.job_id = '6B56A2A5-295C-4D63-A3CE-47DA802560BE';