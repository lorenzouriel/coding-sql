select distinct --top 4
	OBJECT_NAME(p.object_id) as obj_name,
	f.name,
	p.partition_number,
	p.rows
from sys.system_internals_allocation_units a
join sys.partitions p on (p.[partition_id] = a.[container_id])
join sys.filegroups f on (a.[filegroup_id] = f.[data_space_id])
where p.object_id = object_id(N'fact.data')
order by p.partition_number
go


-- LOOP
SELECT 
DB_NAME() AS DbName, 
name AS FileName, 
size/128.0 AS CurrentSizeMB, 
size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)/128.0 AS FreeSpaceMB 
FROM sys.database_files
WHERE type_desc = 'ROWS'
and name like 'FGY'
GO


declare
@alterdb varchar(1024),
@PartNumber varchar = 7

SET @alterdb = 'ALTER TABLE [fact].[data] REBUILD PARTITION = ' + @PartNumber + '
WITH  
(DATA_COMPRESSION = PAGE)'

exec(@alterdb)


declare
@alterdb varchar(1024),
@FileName varchar(100) = 'FGM11_5099EF98'

SET @alterdb = 'DBCC SHRINKFILE ('+ @FileName +')'

EXEC (@alterdb)



SELECT
    [partition_number],
    [data_compression],
    [data_compression_desc]
FROM sys.partitions
WHERE object_id = OBJECT_ID('[fact].[data]');