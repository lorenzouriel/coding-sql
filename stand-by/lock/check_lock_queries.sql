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


--Explicação dos Campos
--session_id: ID da sessão que está aguardando.
--blocking_session_id: ID da sessão que está causando o bloqueio.
--status: Status atual da sessão bloqueada.
--command: Comando sendo executado pela sessão bloqueada.
--wait_type: Tipo de espera.
--wait_time: Tempo que a sessão está esperando pelo recurso.
--wait_resource: Descrição do recurso bloqueado.
--query_text: Texto da query que está em execução.
--host_name, program_name e login_name: Informações adicionais sobre a sessão.