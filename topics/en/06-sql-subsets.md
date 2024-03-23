# SQL Subsets
They are separated into subsets precisely to identify what we are dealing with.

For example, if we want to manipulate data, we use DML (Data Manipulation Language).

**Each subset works with a specific area of ​​the database.**

Let´s check the subsets!

### Data Definition Language (DDL)
Is a subset of SQL that deals with defining or modifying the structure of a database schema.

DDL statements are used to create, modify, and delete database objects such as tables, indexes, views, and stored procedures.

**DDL Statements:**

1. **CREATE:** Used to create new database objects such as tables, views, indexes, etc.
```sql
CREATE TABLE [articles] ( 
    [id] int IDENTITY (1,1) PRIMARY KEY, 
    [name] VARCHAR(150), 
    [author] VARCHAR(50),
    [likes] int NULL
);
```

2. **ALTER:** Used to modify the structure of existing database objects.
```sql
ALTER TABLE [articles]
ADD COLUMN [views] int NULL
```

3. **DROP:** Used to delete existing database objects
```sql
DROP TABLE [articles]
```

4. **TRUNCATE:** Used to remove all records from a table while retaining the table structure.
```sql
TRUNCATE TABLE [articles]
```

### Data Manipulation Language (DML)
Is a subset of SQL used to manipulate data stored in a database.

DML is focused with tasks like querying, inserting, updating, and deleting data within tables.

**DML statements:**

1. **SELECT:** Retrieve data from one or more tables based on specified criteria.
```sql
SELECT * FROM [articles] WHERE [views] >= 1
```

2. **INSERT:** Used to add new rows of data into a table.
```sql
INSERT INTO [articles] (name, author) 
VALUES ('The SQL Week: SQL Subsets', 'Lorenzo Uriel');
```

3. **UPDATE:** Used to modify existing data within a table.
```sql
UPDATE [articles] 
SET [views] = 1
WHERE [name] = 'The SQL Week: SQL Subsets'
```

4. **DELETE:** Used to remove rows of data from a table based on specified conditions.
```sql
DELETE FROM [articles] 
WHERE [name] = 'The SQL Week: SQL Subsets'
```

There is a lot of discussion here, some say that SELECT is part of the DML, others that he is part of the DQL.

But I did some research in Microsoft SQL Server documentation and boom: **SELECT is part of DML**

DQL doesn’t even exist in the documentation, if SQL is a query language in its own right, why will DQL exist?

*Crazy, right?*

### DCL — Data Control Language
These are basically access controls, with them you can give or block access

**DCL statements:**

1. **GRANT:** Grants permissions to a user or role
```sql
GRANT SELECT ON [articles] TO [user]
```

2. **REVOKE:** Revokes permissions designed by GRANT
```sql
REVOKE SELECT ON [articles] TO [user]
```

3. **DENY:** Explicitly denies permissions to a user or role
```sql
DENY DELETE ON [articles] TO [user]
```

### Data Transaction Language (DTL)
*Or Transaction Control Language (TCL)*

Is a subset of SQL used to manage transactions within a database.

In a relational database almost everything is a transaction, these commands is more used in a context of explicits transactions — where the developer explicitly defines the structure of a transaction.

**DTL statements:**

1. **BEGIN TRANSACTION:** Begins a new transaction. All subsequent SQL statements are part of this transaction until it is either committed or rolled back.
```sql
BEGIN TRANSACTION;
-- SQL statements here will be part of the transaction

-- For example:
UPDATE [articles] 
SET [views] = 1
WHERE [name] = 'The SQL Week: SQL Subsets'
```

2. **COMMIT TRANSACTION:** Saves all changes made during the current transaction to the database.
```sql
BEGIN TRANSACTION;
-- SQL statements here will be part of the transaction

-- For example:
UPDATE [articles] 
SET [views] = 1
WHERE [name] = 'The SQL Week: SQL Subsets'

COMMIT TRANSACTION;
```

3. **ROLLBACK TRANSACTION:** Rolls back all changes made during the current transaction.
```sql
BEGIN TRANSACTION;
-- SQL statements here will be part of the transaction

-- For example:
UPDATE [articles] 
SET [views] = 1
WHERE [name] = 'The SQL Week: SQL Subsets'

ROLLBACK TRANSACTION;
```

4. **SAVE TRANSACTION:** Sets a savepoint within the transaction to which you can later roll back.
```sql
BEGIN TRANSACTION;
-- SQL statements here will be part of the transaction

-- For example:
SAVE TRANSACTION MySavepoint;

UPDATE [articles] 
SET [views] = 1
WHERE [name] = 'The SQL Week: SQL Subsets'

-- More SQL statements here
ROLLBACK TRANSACTION MySavepoint;
```
### What about the next steps?

Save the content here, create a database example and go training. It is the best way to learn!
If you have any doubts, just get in contact.