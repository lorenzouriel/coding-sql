SET NOCOUNT ON;

DECLARE 
	@CleanupDate DATETIME;

SET @CleanupDate = DATEADD(DAY, -30, GETDATE());

EXECUTE dbo.sp_purge_jobhistory @oldest_date = @CleanupDate;