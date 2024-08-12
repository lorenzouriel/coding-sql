SELECT
	CASE
		WHEN catalog.Type = 1 THEN 'Folder (1)'
		WHEN catalog.Type = 2 THEN 'Report (2)'
		WHEN catalog.Type = 3 THEN 'File (3)'
		WHEN catalog.Type = 4 THEN 'Linked Report (4)'
		WHEN catalog.Type = 5 THEN 'Data Source (5)'
		WHEN catalog.Type = 6 THEN 'Report Model (6)'
		WHEN catalog.Type = 7 THEN 'Report Part (7)'
		WHEN catalog.Type = 8 THEN 'Shared Data Set (8)'
		WHEN catalog.Type = 9 THEN 'Report Part (9)'
		WHEN catalog.Type = 11 THEN 'KPI (11)'
		WHEN catalog.Type = 12 THEN 'Mobile Report Folder (12)'
		WHEN catalog.Type = 13 THEN 'PowerBI Desktop Document (13)'
	END AS Item_Type,
	catalog.Path,
	catalog.Name,
	users.UserName,
	roles.RoleName,
	roles.Description
FROM ReportServer.dbo.users
INNER JOIN ReportServer.dbo.policyuserrole
ON users.userid = policyuserrole.userid
INNER JOIN ReportServer.dbo.roles
ON roles.roleid = policyuserrole.roleid
INNER JOIN ReportServer.dbo.catalog
ON catalog.policyid = policyuserrole.policyid
ORDER BY catalog.type, catalog.name, users.username;