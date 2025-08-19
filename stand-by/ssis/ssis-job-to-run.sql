-- Step 1: Create a new job
DECLARE @jobId UNIQUEIDENTIFIER
EXEC msdb.dbo.sp_add_job
    @job_name = 'daily_jobs',
    @enabled = 1,
    @description = 'SSIS Job to process daily jobs',
    @job_id = @jobId OUTPUT

-- Step 2: Add job steps for each SSIS package
EXEC msdb.dbo.sp_add_jobstep
    @job_id = @jobId,
    @step_name = 'Daily Data Details',
    @subsystem = 'SSIS',
    @command = '/ISSERVER "\"\SSISDB\Data Mart\ETL\.dtsx\"" /SERVER . /CHECKPOINTING OFF /REPORTING E',
    @on_success_action = 3

EXEC msdb.dbo.sp_add_jobstep
    @job_id = @jobId,
    @step_name = 'Daily Data',
    @subsystem = 'SSIS',
    @command = '/ISSERVER "\"\SSISDB\Data Mart\ETL\.dtsx\"" /SERVER . /CHECKPOINTING OFF /REPORTING E',
    @on_success_action = 3

EXEC msdb.dbo.sp_add_jobstep
    @job_id = @jobId,
    @step_name = 'Daily Events',
    @subsystem = 'SSIS',
    @command = '/ISSERVER "\"\SSISDB\Data Mart\ETL\.dtsx\"" /SERVER . /CHECKPOINTING OFF /REPORTING E',
    @on_success_action = 3

EXEC msdb.dbo.sp_add_jobstep
    @job_id = @jobId,
    @step_name = 'Daily Productivity',
    @subsystem = 'SSIS',
    @command = '/ISSERVER "\"\SSISDB\Data Mart\ETL\.dtsx\"" /SERVER . /CHECKPOINTING OFF /REPORTING E',
    @on_success_action = 3

EXEC msdb.dbo.sp_add_jobstep
    @job_id = @jobId,
    @step_name = 'Daily Stops',
    @subsystem = 'SSIS',
    @command = '/ISSERVER "\"\SSISDB\Data Mart\ETL\daily_stops.dtsx\"" /SERVER . /CHECKPOINTING OFF /REPORTING E',
    @on_success_action = 3

EXEC msdb.dbo.sp_add_jobstep
    @job_id = @jobId,
    @step_name = 'Daily Tracks',
    @subsystem = 'SSIS',
    @command = '/ISSERVER "\"\SSISDB\Data Mart\ETL\.dtsx\"" /SERVER . /CHECKPOINTING OFF /REPORTING E',
    @on_success_action = 1

-- Add more job steps as needed for additional SSIS packages

-- Step 3: Set the job schedule
DECLARE @scheduleId INT
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = 'MinutelySchedule',
    @enabled = 1,
    @freq_type = 4, -- Daily schedule
    @freq_interval = 1, -- Every 1 minute
    @freq_subday_type = 4, -- Minutes
    @freq_subday_interval = 1, -- Every 1 minute
    @active_start_time = 000000, -- 00:00:00 AM (HHMMSS format)
    @active_end_time = 235959, -- 11:59:59 PM (HHMMSS format)
    @schedule_id = @scheduleId OUTPUT

-- Step 4: Attach the job to the schedule
EXEC msdb.dbo.sp_attach_schedule
    @job_id = @jobId,
    @schedule_id = @scheduleId


-- Step 5: Associate the job with a job server
EXEC msdb.dbo.sp_add_jobserver
    @job_name = 'daily_jobs',
    @server_name = @@SERVERNAME; -- Replace 'YourServerName' with the name of your SQL Server instance


-- Step 5: Start the job (optional)
-- EXEC msdb.dbo.sp_start_job @job_id = @jobId
