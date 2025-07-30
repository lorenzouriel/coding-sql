-- Define the Procedure and Input Parameter
CREATE PROCEDURE dbo.usp_send_job_custom_email
    @job_name SYSNAME
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare Variables
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
        @html_body NVARCHAR(MAX);

    -- Get the Job ID from the Name
    SELECT @job_id = job_id 
    FROM msdb.dbo.sysjobs 
    WHERE name = @job_name;

    IF @job_id IS NULL
    BEGIN
        RAISERROR('Job not found.', 16, 1);
        RETURN;
    END

    -- Get the Latest Job Run Information
    DECLARE @run_date INT, @run_time INT, @run_duration INT, @message NVARCHAR(MAX);

    SELECT TOP 1
        @run_date = run_date,
        @run_time = run_time,
        @run_duration = run_duration,
        @message = message
    FROM msdb.dbo.sysjobhistory
    WHERE job_id = @job_id AND step_id = 0
    ORDER BY instance_id DESC;

    -- Convert and Format the Date, Time and Duration
    SELECT @run_datetime = 
        CONVERT(DATETIME,
                STUFF(STUFF(CONVERT(CHAR(8), @run_date), 5, 0, '-'), 8, 0, '-') + ' ' +
                STUFF(STUFF(RIGHT('000000' + CAST(@run_time AS VARCHAR(6)), 6), 3, 0, ':'), 6, 0, ':')
        );

    SELECT 
        @duration = 
            CAST(@run_duration / 10000 AS VARCHAR) + 'h ' + 
            CAST((@run_duration % 10000) / 100 AS VARCHAR) + 'm ' + 
            CAST(@run_duration % 100 AS VARCHAR) + 's';

    -- Get First and Last Step Names and User Info
    SELECT TOP 1 
        @executed_by = suser_sname(),
        @first_step = (SELECT TOP 1 step_name FROM msdb.dbo.sysjobsteps WHERE job_id = @job_id ORDER BY step_id),
        @last_step = (SELECT TOP 1 step_name FROM msdb.dbo.sysjobsteps WHERE job_id = @job_id ORDER BY step_id DESC);

    -- Determine Job Status and Style It
    IF @message LIKE '%succeeded%' 
        SET @status = '<span style="color:green;font-weight:bold">Succeeded</span>';
    ELSE IF @message LIKE '%failed%'
        SET @status = '<span style="color:red;font-weight:bold">Failed</span>';
    ELSE
        SET @status = '<span style="color:orange;font-weight:bold">Unknown</span>';

    -- Build the HTML Email Body
    SET @html_body = 
    N'<html>
    <head>
        <style>
            body { font-family: Segoe UI, sans-serif; color: #333; }
            h2 { color: #2e6c80; }
            table { border-collapse: collapse; width: 100%; margin-top: 10px; }
            th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
            th { background-color: #f2f2f2; }
        </style>
    </head>
    <body>
        <h2>SQL Server Job Notification</h2>
        <table>
            <tr><th>Job Name</th><td>' + @job_name + '</td></tr>
            <tr><th>Status</th><td>' + @status + '</td></tr>
            <tr><th>Run Date</th><td>' + CONVERT(VARCHAR, @run_datetime, 107) + '</td></tr>
            <tr><th>Start Time</th><td>' + CONVERT(VARCHAR, @run_datetime, 114) + '</td></tr>
            <tr><th>Duration</th><td>' + @duration + '</td></tr>
            <tr><th>Executed By</th><td>' + @executed_by + '</td></tr>
            <tr><th>Last Step</th><td>' + ISNULL(@last_step, '-') + '</td></tr>
            <tr><th>Initial Step</th><td>' + ISNULL(@first_step, '-') + '</td></tr>
            <tr><th>Server</th><td>' + @server_name + '</td></tr>
        </table>
        <p style="margin-top: 20px;">Message: ' + @message + '</p>
    </body>
    </html>';

 DECLARE @subject NVARCHAR(255) = '[SQL Job Completed] ' + @job_name;

    -- Send the Email
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'SQL Alerts',
        @recipients = 'lorenzouriel@sqlserver.com',
        @subject = @subject,
        @body_format = 'HTML',
        @body = @html_body;
END