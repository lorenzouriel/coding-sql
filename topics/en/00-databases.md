# SQL
Before we start with the topics and explanations, let's understand the meaning of these three letters?

**SQL = Structure Query Language**

SQL is considered structured because **it follows a specific syntax and pattern in its commands.**

This makes learning easier and sets a standard for how to query the database.

In other words, there is a structured way to solve a challenge.

If there is a problem or task, **users can use structured commands to solve it.**

And Query, well, we basically query everything in a database.

**SQL is not a programming language, it is a Structured Query Language**

#### Why should I learn SQL?

Well...

![sql-meme](/topics/en/imgs/sql-meme.jpg)

# Databases 
A relational database **represents data in a structured manner, organized into tables consisting of rows and columns.**

Each **table within the database holds data related to a specific entity or concept.**

- For instance, in a database for a company, you might have tables for employees, departments, and projects.

The **columns within a table define the attributes or properties of the data being stored.** Each column has a name and a data type, specifying the kind of information it can hold, such as integers, strings, dates, or binary data. 

- For example, in an employee table, you might have columns for employee ID, name, job title, department ID, and hire date.

**Rows, also known as records or tuples, represent individual instances of data within the table.** Each row contains a set of values corresponding to the columns defined in the table. 

- Continuing with the example of an employee table, each row would represent a unique employee and contain specific information about that employee, such as their ID, name, job title, etc.

One of the key features of a relational database is the establishment of relationships between tables. **These relationships define how data in one table is related to data in another.** The relationships are **typically established using keys, such as primary keys and foreign keys.**
- Primary key uniquely identifies each record in a table
- Foreign key establishes a link between two tables by referencing the primary key of another table.

Overall, the **tabular structure of a relational database, along with the relationships between tables, provides a flexible and efficient way to organize and manage large volumes of data.**

This structure allows for easy querying, retrieval, and manipulation of data, making relational databases a popular choice.

***Databases -> Tables (Relationships) -> Columns -> Rows***

## RDBMS vs. SGBD
**Relational Database Management System (RDBMS):**

An RDBMS is a specific type of DBMS that is **based on the relational data model.** 

It organizes data into related tables, where relationships between data are established using keys. 

The main features of an RDBMS include:

1. **Relational Model:** Data is organized in tables with rows and columns, following the relational model.

2. **Referential Integrity:** The RDBMS supports referential integrity, ensuring that relationships between tables are maintained consistently.

3. **ACID Operations:** Transactions in RDBMS are ACID (Atomicity, Consistency, Isolation and Durability), ensuring data reliability and consistency.

4. **SQL:** RDBMS generally support SQL (Structured Query Language) as the default query language to interact with the database.

**Examples:**
- Microsoft SQL Server
- Oracle Database
- PostgreSQL
- MySQL


**Database Management System (DBMS):**
Refers to any tech to manage databases, regardless of the underlying data model. This includes not only RDBMS but also other types of database management systems such as document-oriented databases, time series databases, graph databases, etc.


## T-SQL vs. PL/SQL vs. PL-PgSQL
Do you read a lot about T-SQL and PL/SQL in job descriptions?

These are dialects used to determine which platform SQL will be applied to...

For example:

- **Transact-SQL (T-SQL):** This version of SQL is used by Microsoft SQL Server and Microsoft's Azure SQL services.

- **Procedural Language/SQL (PL/SQL):** This is used by Oracle.

It does not stop there. We have one more example, PostgreSQL also has its own:

- **Procedural Language - Postgree/SQL (PL-PgSQL):** Extensions implemented in PostgreSQL.

In the end, the logic is the same, but you may find some differences in their syntax!


## Bonus: Download SQL Sever with Power Shell
I thought I'd add a **topic just covering a SQL Server installation guide**

But we see this everywhere

I'll do better here

I will **automate the installation and configuration of your SQL Server**

Yes, you will never worry about the Wizard again

Just open your Power Shell ISE and run the scripts below

### Script 01 - Installing SQL Server
```powershell
$isoPath = "$env:C:\SQLServer2019-x64-ENU-Dev.iso"
$driveLetter = "D"

Write-Host "Opening ISO directory..."
Invoke-Item -Path $isoPath 

Write-Host "Waiting for ISO directory to open..."
Start-Sleep -Seconds 5

$extractPath = $driveLetter + ":" 

Write-Host "Installing..."
cmd /c start /wait $extractPath\setup.exe /q /ACTION=Install /FEATURES=SQLEngine,FullText,RS,IS /INSTANCENAME=MSSQLSERVER /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" /TCPENABLED=1 /SECURITYMODE=SQL /SAPWD=Password12! /IACCEPTSQLSERVERLICENSETERMS

Write-Host "Dismounting ISO..."
Dismount-DiskImage -ImagePath $isoPath

Write-Host "OK"
```
***This PowerShell script is designed to automate the installation of SQL Server 2019 using an ISO file. Let's break down the script step by step:***

**1. Setting Variables:**
    
- $isoPath: Path to the SQL Server ISO file.

- $driveLetter: Drive letter where the ISO will be mounted.

**2. Opening ISO Directory:** Opens the directory where the ISO file is located.

**3. Waiting for ISO Directory to Open:** Pauses execution for 5 seconds to allow time for the ISO directory to open.

**4. Extract Path:** Specifies the path where the ISO will be mounted, combining the drive letter and colon (e.g., "D:").

**5. Installing SQL Server:**
- Executes the SQL Server setup in quiet mode (/q).
- Specifies installation actions (/ACTION=Install).
- Specifies the features to install (/FEATURES=SQLEngine,FullText,RS,IS).
- Sets the instance name (/INSTANCENAME=MSSQLSERVER).
- Sets the SQL Server system administrator accounts (/SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS").
- Enables TCP protocol (/TCPENABLED=1).
- Sets security mode to SQL (/SECURITYMODE=SQL).
- Specifies the SQL Server system administrator password (/SAPWD=Password12!).
- Accepts the SQL Server license terms (/IACCEPTSQLSERVERLICENSETERMS).

**6. Dismounting ISO:** Unmounts the ISO file.

**7. Output "OK":** Indicates successful completion of the script.


### Script 02 - Download SQL Server
```powershell
Write-Host "Downloading SQL Server 2019..."
$isoPath = "$env:C:\SQLServer2019-x64-ENU-Dev.iso"
(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/7/c/1/7c14e92e-bdcb-4f89-b7cf-93543e7112d1/SQLServer2019-x64-ENU-Dev.iso', $isoPath)
```

**1. Write-Host "Downloading SQL Server 2019...":**
- This line simply displays a message in the console to indicate that the download process is starting.

**2. $isoPath = "$env:C:\SQLServer2019-x64-ENU-Dev.iso":**
- Here, we're setting the variable $isoPath to store the path where the downloaded ISO file will be saved. $env:C: is an environment variable that refers to the C drive in Windows.

**3. (New-Object Net.WebClient).DownloadFile('URL', $isoPath):**
- This line initiates the download of the SQL Server 2019 ISO file from the specified URL. It uses the DownloadFile method of the WebClient class to download the file and save it to the location specified by $isoPath.