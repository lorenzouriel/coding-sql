# Normalization
Consists of techniques used to avoid data inconsistency and redundancy by structuring the database. It is a set of rules and techniques that help to design and organize the structure of a relational database efficiently.
- **Inconsistency:** Normalization helps maintain data consistency as changes in one table are automatically reflected in other related tables. This avoids inconsistency issues and ensures **referential integrity.**
- **Redundancy:** Avoids unnecessary repetition of data in different parts of the database, which saves storage space and reduces the likelihood of inconsistencies.

We can highlight some **benefits** such as:
- Clear Semantics;
- Avoid NULL values ​​in tuples;
- Better Performance;
- Ease of Maintenance.

We also prevent **anomalies** from:
- Insert;
- Update;
- Delete.

For normalization to occur, we need to apply the **Normal Forms** together with the **Functional Dependencies** rules.
- **NF (Normal Forms)** are techniques used in standardization, they are a series of rules that aim to eliminate redundancy and guarantee data integrity.
- **FD (Functional Dependency)** describes the relationship between attributes in a table, indicating how the value of one attribute determines or is determined by the value of another attribute.

## Functional Dependency
There are different types of functional dependencies that can occur in a database. For the explanation to work clearly, we will use X and Y as:
- `X` (Determinant) — ID
- `Y` (Dependent) — Field

**1 Simple Functional Dependency:** Occurs when the determinant completely determines the value of the dependent.
- We say that `Y` is functionally dependent on `Y` if and only if each value of `Y` is associated with `X`

**2. Partial Functional Dependency:** In this case, the determinant only partially determines the value of the dependent, that is, other attributes can also influence the value of the dependent in addition to the determinant.
- When non-key attributes (`Y`) do not functionally depend on the primary key (`X`) when it is composed.

**3. Total Functional Dependency:** Occurs when a set of attributes determines all other attributes of a table.
- When the dependent attributes (`Y`) depend on the determinant (`X`)

**4. Transitive Functional Dependency:** Occurs when an attribute indirectly determines another attribute through a chain of dependencies.
- When a non-key attribute (`Y`) depends on another non-key attribute (`Y`).

**5. Multivalued Functional Dependency:** Occurs when a set of attributes determines a set of other attributes, but there is no direct functional dependence between the attributes within these sets.
- Occurs when a key attribute (`X`) multidetermines non-key attributes (`Y`) OR (`Y`) is multidependent on (`X`).

*These dependencies are the ones I consider most important in the modeling and normalization process. There are other types of more complex dependencies, which will not be covered in this article. Depending on the complexity of your normalization model, these will be useful.*

## Normal Forms
The best-known normal forms and their rules are as follows:

- **1NF:** Data is organized into tables, with each table containing only atomic and non-repeating values. This means that each value in a column must be indivisible and cannot be a list or set of values.

- **2NF:** In addition to meeting the 1NF criteria, each non-key column of a table must fully depend on the table’s primary key. This means there should be no partial dependencies, where a non-key column only depends on part of the primary key.

- **3NF:** In addition to meeting the 2NF criteria, there must be no transitive dependencies between non-key columns. This means that if a column depends on another column which in turn depends on a third column, then the first column must be moved to a separate table.

- **4NF:** In addition to meeting the 3NF criteria, there must be no multivalued dependencies. This means that there should be no sets of columns that could create undesirable dependencies on each other.

*These normal forms are the ones that I consider most important in the modeling and standardization process. There are other types of more complex normal formals, which will not be covered in this chapter.*