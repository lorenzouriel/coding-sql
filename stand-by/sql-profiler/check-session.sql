EXEC sp_who2;

DBCC INPUTBUFFER(225);

SELECT 
    r.session_id,
    r.status,
    r.wait_type,
    r.blocking_session_id,
    t.text AS sql_text
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.blocking_session_id <> 0;