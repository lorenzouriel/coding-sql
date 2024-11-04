SELECT
    r.session_id,
    r.blocking_session_id,
    r.status,
    r.command,
    r.wait_type,
    r.wait_time,
    r.wait_resource,
    t.text AS query_text,
    s.host_name,
    s.program_name,
    s.login_name
FROM
    sys.dm_exec_requests r
JOIN
    sys.dm_exec_sessions s ON r.session_id = s.session_id
CROSS APPLY
    sys.dm_exec_sql_text(r.sql_handle) t
WHERE
    r.blocking_session_id <> 0
ORDER BY
    r.wait_time DESC;


--Explica��o dos Campos
--session_id: ID da sess�o que est� aguardando.
--blocking_session_id: ID da sess�o que est� causando o bloqueio.
--status: Status atual da sess�o bloqueada.
--command: Comando sendo executado pela sess�o bloqueada.
--wait_type: Tipo de espera.
--wait_time: Tempo que a sess�o est� esperando pelo recurso.
--wait_resource: Descri��o do recurso bloqueado.
--query_text: Texto da query que est� em execu��o.
--host_name, program_name e login_name: Informa��es adicionais sobre a sess�o.