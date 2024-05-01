# Documenting your Database
Documenting a database is often a tiring and repetitive task.

Anyone who has documented it knows. And when something changes in the Schema, we update the documentation or the dictionary.

However, I wish I had seen this post sooner.

Today I can say that I'm here to **document your database.**

You know how lazy it is to create a data dictionary? Or to rewrite each column specifying exactly what is in it?

This ends today!

You will do all this work with just **two commands**

And when do I have to update? Just one command...

After finishing your Task, you'll owe me a coffee.

## tbls - The tool we will use
There is an Open Source tool for this type of task, it has been on the market for a while, it has **very extensive documentation and an active community.**

You can access its documentation [here](https://github.com/k1LoW/tbls?tab=readme-ov-file).

It is important to highlight that it is CI-Friendly, that is, for those who want to implement CI/CD in your Database, it is a good starting point.

To use it, you will need to open the terminal.

But don't worry, in my example, I will run on Windows. The first requirement is that you have Docker installed.

Another requirement is to have a DBMS running locally or access to a server and a database.

I'm running a Microsoft SQL Server locally and the database I'm using in this example is the same as in the [Data Modeling](/topics/en/01-data-modeling.md) article. You can also use it if you want to practice with the same example in the article.

This **tool connects to the most diverse types of databases**, some examples are:
- Microsoft SQL Server
- PostgreSQL
- SQLite
- MySql
- BigQuery
- Snowflake
- Amazon Redshift

And others...

We connect using a **DNS (Data Source Name)** with all the **credentials** necessary for the connection.

This is an example **Microsoft SQL Server:**
```yml
dsn: sqlserver://DbUser:SQLServer-DbPassw0rd@hostname:1433/testdb
```

- `dsn`: This is an identifier used for data connections (Data Source Name). It identifies the data source for the connection.

- `sqlserver://`: This is the protocol used to connect to SQL Server.

- `DbUser`: This is the username used to authenticate the connection to the database.

- `SQLServer-DbPassw0rd`: This is the password associated with the database user.

- `hostname`: This is the address of the server where SQL Server is running. It can be an IP address or a hostname.

- `1433`: This is the default SQL Server port number for TCP/IP connections.

- `testdb`: This is the name of the database you want to connect to.

All connections follow this same pattern, you only need to change the protocol and port.

## Documentation Time (will save your afternoon coffee)

The first step is to install the application, in the documentation they teach in several ways and on different OS. However, unfortunately, there is no example on Windows. :(

Not that this is a problem, **Docker runs through our veins here.** :)

Let's perform a `Docker pull` in cmd itself.
```docker
docker pull ghcr.io/k1low/tbls:latest
```

After finishing the Download, **you can open the directory where you want to document the solution.**

The second step is to add a `.yml` to the directory, the file needs to have these names: `.tbls.yml` or `tbls.yml`.

In `.yml` you will **add your DNS and the path where the documentation goes, in `docPath`**

**Following example:**
```yml
# .tbls.yml

# DSN (Database Source Name) to connect database
dsn: # .tbls.yml
dsn: sqlserver://DbUser:SQLServer-DbPassw0rd@hostname:1433/testdb

# Path to generate document
# Default is `dbdoc`
docPath: docs/schema
```

The third and final step is to **run the command to create the documentation**, here we have a trick because it runs on Docker.

If you had an OS like the one highlighted in the documentation, you could run the command `$ tbls doc` and the documentation would already start.

As we are running on Docker, **let's run the following command:** `docker run --rm -v ${PWD}:/work -w /work ghcr.io/k1low/tbls doc sqlserver://DbUser:SQLServer -DbPassw0rd@hostname:1433/testdb`

And the [magic will begin](https://www.youtube.com/watch?v=NAw7SqHnHLI)...

**Example response:**
![tbls_example](/topics/imgs/08-docs-database/tbls_example.png)

We have **three main files** here:
- `README.md`: A general documentation file, in it you will have a complete overview of the database.
- `tablea.md`: A README.md for each table, with its main characteristics
- `table.svg`: An svg image of each table

Simply put, **this is the result**:
![tbls_readme](/topics/imgs/08-docs-database/tbls_readme.png)

Because it is a README.md, **you can manually supplement the documentation or delve deeper into the tool's documentation.** It offers several other ways to **improve your README.md.**

It will raise the level!