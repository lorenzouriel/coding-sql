SELECT
	Subscriptions.Description,
	Subscriptions.LastStatus,
	Subscriptions.EventType,
	Subscriptions.LastRunTime,
	Subscriptions.Parameters,
	SUBSCRIPTION_OWNER.UserName AS SubscriptionOwner,
	Catalog.Name AS ReportName,
	MODIFIED_BY.UserName AS LastModifiedBy,
	Subscriptions.ModifiedDate
FROM dbo.Subscriptions
INNER JOIN dbo.Users SUBSCRIPTION_OWNER
ON SUBSCRIPTION_OWNER.UserID = Subscriptions.OwnerID
INNER JOIN dbo.Catalog
ON Catalog.ItemID = Subscriptions.Report_OID
INNER JOIN dbo.Users MODIFIED_BY
ON MODIFIED_BY.UserID = Subscriptions.ModifiedByID;