DECLARE 
	@filepath nvarchar(1000) 

SELECT 
	@filepath = cast(value as nvarchar(1000)) FROM [fn_trace_getinfo](NULL) 
WHERE [property] = 2 and traceid=1 

SELECT 
	*
FROM [fn_trace_gettable] (@filepath, DEFAULT) 
WHERE TextData LIKE 'RESTORE DATABASE%' 
ORDER BY StartTime DESC; 