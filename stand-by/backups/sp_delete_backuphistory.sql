SET NOCOUNT ON;

DECLARE 
	@CleanupDate DATETIME;
 
SET @CleanupDate = DATEADD(DAY, -30, GETDATE());

EXECUTE dbo.sp_delete_backuphistory @oldest_date = @CleanupDate;