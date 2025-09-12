# Banco de Dados – Queries

### 2.1 Disponibilidade do Banco

> Percentual de tempo online desde o último restart do SQL Server.

```sql
SELECT 
    d.name AS [Database],
    d.state_desc AS [Status],
    CAST(100.0 * (1 - (rs.[cntr_value] / DATEDIFF(SECOND, sqlserver_start_time, GETDATE()))) AS DECIMAL(5,2)) AS [DisponibilidadePercentual]
FROM sys.databases d
CROSS JOIN sys.dm_os_sys_info si
CROSS APPLY (
    SELECT [cntr_value]
    FROM sys.dm_os_performance_counters
    WHERE counter_name = 'Log Flush Waits/sec'
) rs
CROSS APPLY (
    SELECT sqlserver_start_time FROM sys.dm_os_sys_info
) st;
```

*(Obs: essa métrica é aproximada; para auditoria real, usa-se SQL Server Agent ou soluções como SCOM/Zabbix.)*

---

### 2.2 Conexões ao Banco

```sql
SELECT 
    DB_NAME(dbid) AS [Database],
    COUNT(*) AS [Total Conexões],
    SUM(CASE WHEN status = 'sleeping' THEN 1 ELSE 0 END) AS [Ociosas],
    SUM(CASE WHEN status <> 'sleeping' THEN 1 ELSE 0 END) AS [Ativas]
FROM sys.sysprocesses
WHERE dbid > 0
GROUP BY dbid;
```

---

### 2.3 Performance de Consultas – Tempo Médio de Execução

```sql
SELECT TOP 10
    DB_NAME(st.dbid) AS [Database],
    qs.execution_count,
    qs.total_elapsed_time / qs.execution_count AS [Avg_Elapsed_Time_ms],
    qs.total_worker_time / qs.execution_count AS [Avg_CPU_Time_ms],
    qs.max_elapsed_time AS [Max_Elapsed_Time_ms],
    SUBSTRING(st.text, (qs.statement_start_offset/2)+1,
        ((CASE qs.statement_end_offset
            WHEN -1 THEN DATALENGTH(st.text)
            ELSE qs.statement_end_offset END
            - qs.statement_start_offset)/2)+1) AS [QueryText]
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
ORDER BY [Avg_Elapsed_Time_ms] DESC;
```

---

### 2.4 Alertas de Consultas Lentas (> 30s)

```sql
SELECT 
    DB_NAME(st.dbid) AS [Database],
    qs.execution_count,
    qs.max_elapsed_time AS [Max_Elapsed_Time_ms],
    SUBSTRING(st.text, (qs.statement_start_offset/2)+1,
        ((CASE qs.statement_end_offset
            WHEN -1 THEN DATALENGTH(st.text)
            ELSE qs.statement_end_offset END
            - qs.statement_start_offset)/2)+1) AS [QueryText]
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
WHERE qs.max_elapsed_time > 30000 -- maior que 30 segundos
ORDER BY qs.max_elapsed_time DESC;
```

---

### 2.5 Último Backup Realizado

```sql
SELECT 
    d.name AS [Database],
    MAX(b.backup_finish_date) AS [UltimoBackup],
    b.type AS [Tipo]
FROM msdb.dbo.backupset b
JOIN sys.databases d ON b.database_name = d.name
GROUP BY d.name, b.type
ORDER BY [UltimoBackup] DESC;
```

---

### 2.6 Tipo de Backup (FULL, DIFFERENTIAL, LOG)

```sql
SELECT 
    d.name AS [Database],
    CASE b.type
        WHEN 'D' THEN 'FULL'
        WHEN 'I' THEN 'DIFFERENTIAL'
        WHEN 'L' THEN 'LOG'
        ELSE 'OTHER'
    END AS [TipoBackup],
    MAX(b.backup_finish_date) AS [UltimoBackup]
FROM msdb.dbo.backupset b
JOIN sys.databases d ON b.database_name = d.name
GROUP BY d.name, b.type
ORDER BY [UltimoBackup] DESC;
```

---

# ⚡ Versão Consolidada (CTEs)

Se você quiser **um único script** com tudo junto, eu monto usando `WITH` (CTEs) e no final você faz selects separados ou um UNION para dashboard.

Quer que eu já te entregue esse consolidado num **único script** pronto para rodar, ou prefere manter separado por métrica como workbook?
