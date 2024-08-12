USE [master]
GO
EXECUTE [dbo].[IndexOptimize] @Databases = 'data_mart',
@FragmentationLow = NULL,
@FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
@FragmentationLevel1 = 5,  
@FragmentationLevel2 = 30,
@PageCountLevel = 1,
@WaitAtLowPriorityMaxDuration = 1,
@WaitAtLowPriorityAbortAfterWait = 'NONE',
@UpdateStatistics = 'ALL',
@OnlyModifiedStatistics = 'Y', 
@LogToTable = 'Y'