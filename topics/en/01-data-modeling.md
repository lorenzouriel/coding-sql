## Data Modeling

Anyone who knows me knows that I enjoy drawing and following processes. I believe that this is the core to solving any problem.

Having good documentation and a well-defined process will make you more confident to apply and create something.

And one of the processes I love the most is Data Modeling. Seriously, it's the kind of work I do while listening to music because it's so enjoyable.

So, what does the modeling process consist of?

### We can mention:
1. Requirements Analysis
2. Conceptual Model (ERD - ERM)
3. Logical Model (Tables and Relationships)
4. Physical Model (Table Creation in the database)

These will be the topics of this chapter, and in the end, I want to build a real example with you, from scratch.

## Requirements Analysis
Requirements analysis is the initial and fundamental phase in the data modeling process. It's the advice we see most on our beloved LinkedIn -> **communication, my friends!**

This stage involves understanding and documenting user and system needs, identifying relevant data, and defining the system's functional and non-functional requirements.

Crucial to ensure that the data model is built to meet stakeholders' expectations and needs.

**Steps for analyzing requirements:**
1. **Understanding the problem:** Detailed understanding of the system context, its goals, and constraints.

2. **Requirements collection:** Gathering information about the requirements.

3. **Analysis and documentation:** Analyzing the collected requirements to identify inconsistencies and detailed documentation of the requirements.

4. **Requirements Validation:** This step talks a lot to the next one, only when we create relationships and diagrams do we realize that some requirements are missing.

The idea here is active participation of stakeholders to ensure that business needs are adequately captured and translated into data requirements.

They don't need to know what the field type [name] will be, but it's good to confirm with them if the [name] field is really necessary.

## Conceptual Model (ERD - ERM)
It is created through diagrams such as **ERD (Entity-Relationship Diagram) or ERM (Entity-Relationship Model).**

These diagrams **help visualize entities, their attributes, and the relationships between them in an abstract way, without considering implementation details.**

To understand the purpose of a conceptual model, let's understand some important points first:
- Entities
- Relationships
- Cardinalities
- Attributes

### Entities
Anyone who programs or has programmed knows that an **entity** is an **object of the real world.** To simplify even further, it is our **table.**

It can be **abstract** or **complete:**
- *An **abstract entity** is a general concept, with no specific defined characteristics.*

- *A **complete entity**, on the other hand, is a specific instance of an abstract entity, with distinct and well-defined characteristics.*

Entities are represented in rectangular models:
- ![entity](/topics/imgs/01_data_modelling/e.png)

There are two types of entities, **strong** and **weak**:

- **Strong:** Does not depend on the existence of another entity.

- **Weak:** Depends on another owning entity. These are represented with two rectangles.
    - ![entity](/topics/imgs/01_data_modelling/ef.png)


### Relationships
They are basically **how entities talk and relate to each other.**
- ![relationship](/topics/imgs/01_data_modelling/relationships.png)

The degrees of relationships are:

**1. Binary Relationship:** Two entities participate in a relationship.
- ![relationship](/topics/imgs/01_data_modelling/relationships.png)

**2. Ternary Relationship:** Where three entities participate in a relationship.
- ![relationship](/topics/imgs/01_data_modelling/relationships_ter.png)

**3. N-ary Relationship:** Where four or more entities participate in a relationship.
- ![relationship](/topics/imgs/01_data_modelling/relationships_nario.png)

And it's in these relationships that we define the **cardinalities.**

### Cardinality
Cardinality refers to the **number of occurrences of an entity that are related to another entity through a relationship.**

There are two main types of cardinalities:
- **Minimum Cardinality:** Indicates the minimum number of occurrences of an entity that must be related to another entity.

- **Maximum Cardinality:** Indicates the maximum number of occurrences of an entity that can be related to another entity.

**Cardinality Notations:**
- **(0,1):** Zero or one occurrence.
- **(1,1):** Exactly one occurrence.
- **(0,N):** Zero or more occurrences.
- **(1,N):** One or more occurrences.

As there is often a lot of confusion in this stage, I will give you some examples:
- **1,1 (One to One):** A customer has exactly one address, and an address belongs to only one customer.

- **1,N (One to Many):** A department can have many employees, but an employee can only belong to one department.

- **N,M (Many to Many):** A student can enroll in many courses, and a course can have many enrolled students. This is usually modeled using a junction table.

***Curiosity:** I learned about Cardinality in the first semester of college and only really used it almost a year after graduating.*


### Attributes
Attributes are nothing more than the **characteristics of an entity**, in other words, their **fields.**

They are represented as extensions in rectangles:
- ![attributtes](/topics/imgs/01_data_modelling/atributtes.png) 

The types of attributes are:

- **Atomic:** Unique and indivisible.
    - Examples are: CPF, CNPJ

- **Composite:** Can be divided into smaller parts.
    - Examples are: Address, Name

- **Multi-valued:** Can have N associated values.
    - Examples are: Numbers, cell phones

- **Derived:** Depends on another attribute or entity.
    - Examples are: Age -> Date of Birth

- **Key:** Used as an identifier.
    - Examples are: PKs and FKs

With these concepts, we can create our **conceptual model**, which is nothing more than a **high-level representation of entities and their relationships in a business domain.**

Our database is a **habit tracking** one, and I left the conceptual model without the specified attributes. Only the **entities, relationships, and cardinality.**
- ![conceptual_model](/topics/imgs/01_data_modelling/conceptual_model.png) 


## Logical Model (Tables and Relationships)
The Logical Model is a **more detailed representation of the database, which translates the conceptual model into terms closer to physical implementation.** The logical modeling **does not include indexes and constraints**, only the **representation of tables and their relationships.**

It describes the tables, their attributes, and the relationships between them in a more concrete way, using data modeling languages like the Relational Model.

In this phase, the entities of the ERD/ERM are mapped to tables, attributes are mapped to columns, and relationships are mapped to foreign keys.

The logical model serves as a basis for implementing the database and is used to design queries and transactions.

- ![logical_model](/topics/imgs/01_data_modelling/logical_model.png) 

## Physical Model (Table Creation in the Database)
The Physical Model is the **concrete implementation of the database, which involves the actual creation of tables and other objects in the database as defined in the logical model.**

It describes how data will be stored and accessed physically in the database, **including details such as data types, indexes, integrity constraints, and partitions.**

The physical model is specific to the chosen database management system (DBMS) and is often created using **SQL (Structured Query Language)** or database modeling tools. 

It is in this phase that we create documentation such as a data dictionary and add our schemas to a repository.

With that, your project goes to another level!

Example of the diagram as a physical model:
- ![physical_model](/topics/imgs/01_data_modelling/physical_model.png) 

Another way to represent this physical model is with the **SQL scripts for creating the tables.** Examples:
```sql
CREATE TABLE [contacts] (
	[id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[name] [varchar](50) NOT NULL,
	[surname] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[phone_number] [varchar](50) NOT NULL,
	[status] bit DEFAULT(1) NOT NULL
	)

CREATE TABLE [goals] (
	[id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](150) NOT NULL,
	[contact_id] INT NOT NULL,
	[start] date NOT NULL,
	[end] date NOT NULL,
	[achieved] bit DEFAULT(0) NOT NULL,
	[status] bit DEFAULT(1) NOT NULL
	CONSTRAINT FK_goals_contacts FOREIGN KEY (contact_id) REFERENCES contacts(id)
)

CREATE TABLE [habits] (
	[id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](150) NOT NULL,
	[contact_id] INT NOT NULL,
	[per_week] INT NOT NULL,
	[per_month] INT NOT NULL,
	[per_year] INT NOT NULL,
	[status] bit DEFAULT(1) NOT NULL
	CONSTRAINT FK_habits_contacts FOREIGN KEY (contact_id) REFERENCES contacts(id)
)

CREATE TABLE [tracking] (
	[id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[habit_id] INT NOT NULL,
	[date] date NOT NULL,
	[level] bit DEFAULT(0) NOT NULL
	CONSTRAINT FK_tracking_habits FOREIGN KEY (habit_id) REFERENCES habits(id)
)
```

Following this process and documenting are good practices related to the modeling process. Always keep in mind what a process is for and why it should be respected.

### To close...

I found this table that summarizes the differences between the models:
- ![types](/topics/imgs/01_data_modelling/table_types_of_modelling.png) 
