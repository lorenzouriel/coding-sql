-- Queries that recently regressed in performance
-- The following query example returns all queries for which execution time doubled in the last 48 hours due to a plan choice change. This query compares all runtime stat intervals side by side:
SELECT qt.query_sql_text,
    q.query_id,
    qt.query_text_id,
    rs1.runtime_stats_id AS runtime_stats_id_1,
    rsi1.start_time AS interval_1,
    p1.plan_id AS plan_1,
    rs1.avg_duration AS avg_duration_1,
    rs2.avg_duration AS avg_duration_2,
    p2.plan_id AS plan_2,
    rsi2.start_time AS interval_2,
    rs2.runtime_stats_id AS runtime_stats_id_2
FROM sys.query_store_query_text AS qt
INNER JOIN sys.query_store_query AS q
    ON qt.query_text_id = q.query_text_id
INNER JOIN sys.query_store_plan AS p1
    ON q.query_id = p1.query_id
INNER JOIN sys.query_store_runtime_stats AS rs1
    ON p1.plan_id = rs1.plan_id
INNER JOIN sys.query_store_runtime_stats_interval AS rsi1
    ON rsi1.runtime_stats_interval_id = rs1.runtime_stats_interval_id
INNER JOIN sys.query_store_plan AS p2
    ON q.query_id = p2.query_id
INNER JOIN sys.query_store_runtime_stats AS rs2
    ON p2.plan_id = rs2.plan_id
INNER JOIN sys.query_store_runtime_stats_interval AS rsi2
    ON rsi2.runtime_stats_interval_id = rs2.runtime_stats_interval_id
WHERE rsi1.start_time > DATEADD(hour, -48, GETUTCDATE())
    AND rsi2.start_time > rsi1.start_time
    AND p1.plan_id <> p2.plan_id
    AND rs2.avg_duration > 2 * rs1.avg_duration
ORDER BY q.query_id,
    rsi1.start_time,
    rsi2.start_time;

-- If you want to see all performance regressions (not only regressions related to plan choice change), remove condition AND p1.plan_id <> p2.plan_id from the previous query.