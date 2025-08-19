USE [your_db]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[AutomaticallyProfiler]

SELECT	'Return Value' = @return_value

GO
