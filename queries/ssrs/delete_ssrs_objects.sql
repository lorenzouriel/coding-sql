SELECT 
	*
FROM [dbo].[Catalog]
WHERE [Path] like '%/Geotracker Reports%'


SELECT 
	*
FROM [dbo].[DataSource]
WHERE [ItemID] in (
	SELECT 
		[ItemID]
	FROM [dbo].[Catalog]
	WHERE [Path] like '%/Geotracker Reports%')
