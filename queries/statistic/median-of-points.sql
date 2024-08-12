create table [median]
(
    id int identity (1,1) not null,
    [user_id] int null,
    median float null,
    q1 float null,
    q3 float null
)

-- Calculate median of points
SELECT
	*
FROM [dbo].[sla]
WHERE [user_id] = 80000 


SELECT 
	*
FROM [dbo].[sla]
WHERE [user_id] = 80000 
ORDER BY [tot_points]


SELECT 
	*
FROM [dbo].[median]
WHERE [user_id] = 80000 


SELECT top 1
  [user_id],
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY tot_points) OVER () AS median,
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY tot_points) OVER () AS q1,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY tot_points) OVER () AS q3
FROM [sla]
where [user_id] = 80000


-- Calculate percentile of points
SELECT top 1
  [user_id],
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY tot_points) OVER () AS median,
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY tot_points) OVER () AS q1,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY tot_points) OVER () AS q3
FROM sla
where [user_id] = 80000


SELECT top 1
  [user_id],
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY tot_points) OVER () AS median
FROM sla
where [user_id] = 80000