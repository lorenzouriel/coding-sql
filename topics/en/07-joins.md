# Joins
Of course you've heard of **join types**.

I want to highlight the main points between the existing joins and give examples of their uses.

The idea is to cover various topics about SQL, and joins are one of them, very important for your daily life using SQL.

![joins](/topics/imgs/07-joins/types_joins.png)

- *We'll use the database we created in the [data modeling article](/topics/en/01-data-modeling.md)*

## INNER JOIN
Retrieves records **from both tables where there is a match based on the specified condition.** If there is no matching record in either of the tables, the rows won't appear in the result set.

An INNER JOIN is the most common type of join in SQL; I'm sure you've done it at least once.

It combines rows from two tables based on a related column between them; you need a field that exists in both tables.

The result set contains only the rows for which the join condition is true in both tables; if the `id` is orphaned, there's probably something wrong with your tables.

For **INNER JOIN, you can just write JOIN.**

**Example:**
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

In this example, **I'm performing the join to identify the name and description of each habit practiced on the dates.**

## LEFT JOIN
LEFT JOIN is **useful when you want to retrieve all records from the left table regardless of whether there is a corresponding record in the right table.**

If there's no match in the right table, NULL values are returned for the columns from the right table.

**Example:**
```sql
SELECT 
	*
FROM habits h
LEFT JOIN contacts c ON (h.[contact_id] = c.[id])
```

**Result:**
- ![left_join](/topics/imgs/07-joins/left_join.png)

We can see that the contact with `id` 03 doesn't exist in the `contacts` table; therefore, the return related to this row will be NULL.

## RIGHT JOIN
It's similar to a LEFT JOIN, but **it retrieves all records from the right table and the matching records from the left table.**

If there's no match in the left table, NULL values are returned for the columns from the left table.

RIGHT JOIN is **less commonly used than LEFT JOIN, but it can be useful in certain situations, especially when you want to focus on the data from the right table.**

**Example:**
```sql
SELECT 
	*
FROM habits h
RIGHT JOIN contacts c ON (h.[contact_id] = c.[id])
```

**Result:**
- ![right_join](/topics/imgs/07-joins/right_join.png)

We can see that the contact with `id` 04 doesn't exist in the `contacts` table, and it's not related to any habit, so the returns from the `habits` table come back as NULL.

## FULL JOIN 
Retrieves all records **when there is a match in the left or right table.** 

If there's no match, **NULL values are returned for the columns from the table without a corresponding row.**

FULL JOIN is useful when you want **to retrieve all records from both tables and see where they match or not.**

**Example:**
```sql
SELECT 
	*
FROM tracking tr
FULL JOIN time t ON (tr.[date] = t.[date])
```

**Result:**
- ![full_join](/topics/imgs/07-joins/full_join.png)

Here, I'm creating a timeline in this data, **I can analyze all the days a habit was practiced and the days it wasn't.**

In this example, it will only duplicate the row where a habit occurred; if three habits were performed on day 02, then there will be three rows on day 02. This is a **FULL JOIN**; you identify occurrences in both tables.

**Complete Example:**
```sql
SELECT 
	h.[name],
	h.[description],
	t.[date],
	tr.[date],
	tr.[level]
FROM [tracking] tr
FULL JOIN [time] t ON (tr.[date] = t.[date])
LEFT JOIN [habits] h ON (h.[id] = tr.[habit_id])
```

**Result:**
- ![full_join_2](/topics/imgs/07-joins/full_join_2.png)

A LEFT JOIN was performed to fetch the fields from the dimension and have a more complete query, linking two dimensions into one fact. **We're analyzing information from a timeline with descriptions from another dimension table.**

Can you draw some insights already?

## CROSS JOIN
Returns the Cartesian product of the two tables, **combining each row from the first table with each row from the second table.**

Unlike other joins, **it doesn't require any condition to be met.**

CROSS JOIN **generates a result set with the total number of rows equal to the number of rows in each table.**

It can be useful for **generating data combinations,** but it can also **result in large result sets.**

**Example:**
```sql
SELECT 
	*
FROM habits hr
CROSS JOIN contacts
```

**Result:**
- ![cross_join](/topics/imgs/07-joins/cross_join.png)

I'll bring a similar example to the one used in the FULL JOIN, and we'll identify their differences.

**Complete Example:**
```sql
SELECT 
	h.[name],
	h.[description],
	t.[date],
	tr.[date],
	tr.[level]
FROM [habits] h
CROSS JOIN [time] t
LEFT JOIN [tracking] tr ON (h.[id] = tr.[habit_id] and t.[date] = tr.[date])
```

**Result:**
- ![cross_join_2](/topics/imgs/07-joins/cross_join_2.png)

The difference between **CROSS** and **FULL** is that with **FULL,** we only duplicate the rows where there are occurrences, while **CROSS** will cross all rows of the `time` table with the `habits` table.

That is, if there are 366 records in the `time` table and only 03 records in the `habits` table, SQL will return 1,098 records. In the case of **LEFT JOIN,** we use it with the same goal of identifying on which date that habit was practiced.

## Which to Use?
Indeed, **INNER JOIN is the most commonly used in SQL queries.**

Personally, **I tend to resort to LEFT and RIGHT JOINs when I'm analyzing the tables I have, often to examine the presence or absence of values. Or, as shown in the examples above, sometimes we need a LEFT to fetch only existing records without duplication.**

**FULL JOIN,** on the other hand, is reserved for scenarios like the one described above – **instances where we need to correlate with a timeline.** You can also use it **when analyzing data where some records may be missing in one dataset but present in another, to ensure no data is lost during the join operation.**

**CROSS JOIN** is useful **when you need to generate all possible data combinations,** such as when creating test data for a database or when performing certain types of analysis. You can also **use it in scenarios where you need to compare each item from one set with each item from another set.**

It largely depends on the need and your challenge!

## UNION vs. UNION ALL
Both **UNION** and **UNION ALL** are used to **combine results from two or more queries into a single result set.** However, they have important differences in their behavior:

- ***Note:** I created a table identical to my `habits` and added new records for comparison purposes.*

### UNION
Combines the results of two or more queries into a single result set. 

**It automatically removes any duplicate records that may arise between the queries.**

It's useful when you want **to combine results from multiple queries and ensure there are no duplicate records in the final results.**

The idea is to generate a unique result set.

**Example of UNION:**
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
Combines **the results of two or more queries into a single result set.** 

However, unlike UNION, it doesn't remove duplicate records - **it simply combines all results, including duplicates if any.**

It's faster than UNION because it doesn't need to check and eliminate duplicate records.

Use **UNION ALL** when you want to combine all results or when you're sure there won't be duplicate records and want to improve performance.

**Example of UNION ALL:**
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

### What are the Next Steps?
Save the content, create a database example, and start practicing. It's the best way to learn!

If you have any questions, feel free to reach out.