SELECT 
    r.session_id,
    r.start_time,
    r.status,
    r.command,
    t.text AS sql_text,
    s.program_name,
    s.login_name,
    s.host_name
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE s.program_name LIKE 'SQLAgent%';

KILL <session_id>;  --Use with caution!