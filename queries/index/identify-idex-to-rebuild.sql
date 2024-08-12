SELECT 
    S.name as 'Schema',
    T.name as 'Table',
    I.name as 'Index',
    DDIPS.avg_fragmentation_in_percent,
    DDIPS.page_count
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS DDIPS
INNER JOIN sys.tables T on T.object_id = DDIPS.object_id
INNER JOIN sys.schemas S on T.schema_id = S.schema_id
INNER JOIN sys.indexes I ON I.object_id = DDIPS.object_id
AND DDIPS.index_id = I.index_id
WHERE DDIPS.database_id = DB_ID()
and I.name is not null
AND DDIPS.avg_fragmentation_in_percent >= 0
ORDER BY DDIPS.avg_fragmentation_in_percent desc
