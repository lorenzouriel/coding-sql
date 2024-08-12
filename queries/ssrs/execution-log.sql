SELECT
    C.[Path] AS [ReportPath],
    C.[Name] AS [ReportName],
	CAST(E.[Parameters] as varchar) AS [Parameters],
    COUNT(*) AS [ViewCount]
FROM ExecutionLog AS E
JOIN Catalog AS C ON E.ReportID = C.ItemID
GROUP BY C.Path, C.Name, CAST(E.[Parameters] as varchar)
ORDER BY ViewCount DESC


SELECT *
FROM (
	SELECT
		C.[Path] AS [ReportPath],
		C.[Name] AS [ReportName],
		SUBSTRING(E.[Parameters], CHARINDEX('cliente=', E.[Parameters]) + LEN('cliente='), CHARINDEX('&', E.[Parameters], CHARINDEX('cliente=', E.[Parameters])) - CHARINDEX('cliente=', E.[Parameters]) - LEN('cliente=')) AS [Cliente],
		COUNT(*) AS [ViewCount]
	FROM ExecutionLog AS E
	JOIN Catalog AS C ON E.ReportID = C.ItemID
	WHERE E.[Parameters] LIKE '%cliente=%'
	GROUP BY C.[Path], C.[Name], SUBSTRING(E.[Parameters], CHARINDEX('cliente=', E.[Parameters]) + LEN('cliente='), CHARINDEX('&', E.[Parameters], CHARINDEX('cliente=', E.[Parameters])) - CHARINDEX('cliente=', E.[Parameters]) - LEN('cliente='))
) [Log]
ORDER BY [Log].[ViewCount] DESC


SELECT 
	[Log].*,
FROM (
	SELECT
		C.[Path] AS [ReportPath],
		C.[Name] AS [ReportName],
		SUBSTRING(E.[Parameters], CHARINDEX('cliente=', E.[Parameters]) + LEN('cliente='), CHARINDEX('&', E.[Parameters], CHARINDEX('cliente=', E.[Parameters])) - CHARINDEX('cliente=', E.[Parameters]) - LEN('cliente=')) AS [Cliente],
		COUNT(*) AS [ViewCount]
	FROM ExecutionLog AS E
	JOIN Catalog AS C ON E.ReportID = C.ItemID
	WHERE E.[Parameters] LIKE '%cliente=%'
	GROUP BY C.[Path], C.[Name], SUBSTRING(E.[Parameters], CHARINDEX('cliente=', E.[Parameters]) + LEN('cliente='), CHARINDEX('&', E.[Parameters], CHARINDEX('cliente=', E.[Parameters])) - CHARINDEX('cliente=', E.[Parameters]) - LEN('cliente='))
) [Log]
ORDER BY [Log].[ViewCount] DESC
