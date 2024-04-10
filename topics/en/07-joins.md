# Joins
Of course you already have heard about the **types of joins**

I want to raise the main points among existing joins and give examples of their uses

The idea is to address several topics about SQL and joins is one of them, very important for your daily life using SQL

![joins](/topics/imgs/07-joins/types_joins.png)

- *We will use the database that we create in the [data modeling article](/topics/en/01-data-modeling.md)*


## INNER JOIN
Retrieves records **from both tables where there is a match based on the specified condition.** If there is no matching record in either table, the rows will not appear in the result set.

An INNER JOIN is the most common type of join in SQL, I have sure you did it at least once!

It combines rows from two tables based on a related column between them, you need a field that exists in both table.

The result set contains only the rows for which the join condition is true in both tables, if the `id` is orphan, probably is something wrong with your tables.

For **INNER JOIN you can write only JOIN.**

**INNER JOIN example:**
```sql
SELECT 
	h.[name],
	h.[description],
	t.[date],
	t.[level]
FROM tracking t
INNER JOIN habits h ON (t.[habit_id] = h.[id])
-- JOIN habits h ON (t.[habit_id] = h.[id])
```

**Result:**
- ![inner_join](/topics/imgs/07-joins/inner_join.png)

In this example, I am **performing the join to identify the name and description of each habit practiced in the data.**

## LEFT JOIN (or LEFT OUTER JOIN)
Retrieves all records **from the left table and matching records from the right table.** 

If there is no match in the right table, NULL values are returned for the columns from the right table.

LEFT JOIN is **useful when you want to retrieve all records from the left table regardless of whether there is a matching record in the right table.**

**LEFT JOIN example:**
```sql
SELECT 
	*
FROM old_habits oh
LEFT JOIN habits h ON (h.id = oh.[id])
```
- ***Obs:** For this example I create another table similar to habits and add two more rows*

**Result:**
- ![left_join](/topics/imgs/07-joins/left_join.png)

## RIGHT JOIN (or RIGHT OUTER JOIN):
Is similar to a LEFT JOIN but **retrieves all records from the right table and matching records from the left table.** 

If there is no match in the left table, NULL values are returned for the columns from the left table.

RIGHT JOIN is **less commonly used than LEFT JOIN but can be useful in certain situations, especially when you want to focus on the data from the right table.**

**RIGHT JOIN example:**
```sql
SELECT 
     oh.[name], 
     h.[name] 
FROM habits h
RIGHT JOIN old_habits oh ON (h.id = oh.[id])
```

**Result:**
- ![right_join](/topics/imgs/07-joins/right_join.png)


## FULL JOIN (or FULL OUTER JOIN)
Retrieves all records **when there is a match in either the left or right table.** 

If there is no match, **NULL values are returned for the columns from the table without a matching row.**

FULL JOIN is useful when you want to **retrieve all records from both tables and see where they match or where they don't.**

**FULL JOIN example:**
```sql
SELECT 
	*
FROM tracking tr
FULL JOIN time t ON (tr.[date] = t.[date])
```

**Result:**
- ![full_join](/topics/imgs/07-joins/full_join.png)

Here I am creating a timeline on this data, **I can analyze all the days that a habit was performed and the days that were not.**

## CROSS JOIN
Returns the Cartesian product of the two tables, **it combines each row of the first table with every row of the second table.**

Unlike other joins, **it does not require any condition to be met.**

CROSS JOIN **generates a result set with the total number of rows equal to the product of the number of rows in each table.**

It can be useful for **generating combinations of data**, but it can also **result in very large result sets if the tables involved are large.**

**CROSS JOIN example:**
```sql
SELECT 
	*
FROM tracking tr
CROSS JOIN contacts
```

**Result:**
- ![cross_join](/topics/imgs/07-joins/cross_join.png)

Now, i'm going to insert another contact

- ![cross_join_2](/topics/imgs/07-joins/cross_join_2.png)

This is achieved by combining every row from the `habits` table with every row from the `contacts` table, **resulting in a Cartesian product of the two tables.**

Indeed, **INNER JOIN is the most used in SQL queries.**

Personally, **I tend to resort to LEFT and RIGHT JOINs when I'm delving deep into data analysis, often to examine the presence or absence of values, LEFT for data validation is gold, my friends!**

**FULL JOIN**, on the other hand, is reserved for scenarios like the one described above – **instances where we need to correlate with a comprehensive timeline.** 

As for **CROSS JOIN**, it's not typically used, **just for specific purposes such as appending a signature to every row.**


## Bonus: Union vs. Union All
Both **UNION** and **UNION ALL** are used to **combine results from two or more queries into a single result list.** However, they have important differences in their behavior:

### UNION
Combines the results of two or more queries into a single result list. **It automatically removes any duplicates that may arise between queries.**

It's useful when you want to **combine results from multiple queries and ensure there are no duplicates in the final results.**

Use **UNION** when you want to eliminate duplicates and produce a unique result set.

**UNION example:**
```sql
SELECT 
	*
FROM [tracking_habits].[dbo].[habits]

UNION

SELECT 
	*
FROM [tracking_habits].[dbo].[old_habits]
```

**Result:**
- ![union](/topics/imgs/07-joins/union.png)

### UNION ALL
Combines the **results of two or more queries into a single result list.** However, unlike UNION, it does not remove duplicates - **it simply combines all results, including duplicates if any.**

It is faster than UNION as it does not need to check and eliminate duplicates.

Use **UNION ALL** when you want to combine all results, including duplicates, or when you are sure there will be no duplicates and want better performance.

**UNION ALL example:**
```sql
SELECT 
	*
FROM [tracking_habits].[dbo].[habits]

UNION ALL

SELECT 
	*
FROM [tracking_habits].[dbo].[old_habits]
```

**Result:**
- ![union_all](/topics/imgs/07-joins/union_all.png)


### What about the next steps?
Save the content here, create the database example and go training. **It is the best way to learn!**

If you have any doubts, just get in contact.