    DECLARE 
        @job_id UNIQUEIDENTIFIER,
        @run_datetime DATETIME,
        @duration VARCHAR(20),
        @start_time TIME,
        @status VARCHAR(100),
        @executed_by SYSNAME,
        @server_name SYSNAME = CONVERT(SYSNAME, SERVERPROPERTY('MachineName')),
        @last_step NVARCHAR(128),
        @first_step NVARCHAR(128),
        @html_body NVARCHAR(MAX),
		@job_name SYSNAME = 'test_routine'

    -- Get job ID
    SELECT @job_id = job_id 
    FROM msdb.dbo.sysjobs 
    WHERE name = @job_name;

    IF @job_id IS NULL
    BEGIN
        RAISERROR('Job not found.', 16, 1);
        RETURN;
    END

    -- Get latest run from job history (step_id = 0 = job outcome)
    DECLARE @run_date INT, @run_time INT, @run_duration INT, @message NVARCHAR(MAX);

    SELECT TOP 1
        @run_date = run_date,
        @run_time = run_time,
        @run_duration = run_duration,
        @message = message
    FROM msdb.dbo.sysjobhistory
    WHERE job_id = @job_id AND step_id = 0
    ORDER BY instance_id DESC;

    -- Convert run_date and run_time to datetime
    SELECT @run_datetime = 
        CONVERT(DATETIME,
                STUFF(STUFF(CONVERT(CHAR(8), @run_date), 5, 0, '-'), 8, 0, '-') + ' ' +
                STUFF(STUFF(RIGHT('000000' + CAST(@run_time AS VARCHAR(6)), 6), 3, 0, ':'), 6, 0, ':')
        );

    -- Get duration in human format
    SELECT 
        @duration = 
            CAST(@run_duration / 10000 AS VARCHAR) + 'h ' + 
            CAST((@run_duration % 10000) / 100 AS VARCHAR) + 'm ' + 
            CAST(@run_duration % 100 AS VARCHAR) + 's';

    -- Get user, steps
    SELECT TOP 1 
        @executed_by = suser_sname(),
        @first_step = (SELECT TOP 1 step_name FROM msdb.dbo.sysjobsteps WHERE job_id = @job_id ORDER BY step_id),
        @last_step = (SELECT TOP 1 step_name FROM msdb.dbo.sysjobsteps WHERE job_id = @job_id ORDER BY step_id DESC);

    -- Get status from message
    IF @message LIKE '%succeeded%' 
        SET @status = '<span style="color:green;font-weight:bold">Succeeded</span>';
    ELSE IF @message LIKE '%failed%'
        SET @status = '<span style="color:red;font-weight:bold">Failed</span>';
    ELSE
        SET @status = '<span style="color:orange;font-weight:bold">Unknown</span>';

	PRINT(@job_name)
	PRINT(@status)
	PRINT(CONVERT(VARCHAR, @run_datetime, 107))
	PRINT(CONVERT(VARCHAR, @run_datetime, 114))
	PRINT(@duration)
	PRINT(@executed_by)
	PRINT(ISNULL(@last_step, '-'))
	PRINT(ISNULL(@first_step, '-'))
	PRINT(@server_name)
	PRINT(@message)