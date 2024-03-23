# ACID Properties

Ever heard of ACID properties? It’s time!

**ACID** properties are a set of characteristics that ensure data reliability and consistency in relational database management systems. The term **ACID** is an acronym formed by the first letters of the four properties that compose it: 
- Atomicity
- Consistency
- Isolation
- Durability

**ACID** properties emerged when relational database management systems started to become popular, where they were primarily used for financial and other data-critical applications. 

As a result, it was necessary to establish a **set of standards that would guarantee data integrity.**

**ACID** properties were developed to address this need, quickly becoming a standard for relational database systems. They have been incorporated into many relational database management systems, including Oracle, MySQL and PostgreSQL, to ensure data reliability and consistency across all applications.

The **ACID** properties are as follows:

1. **Atomicity:** Either everything happens or nothing is considered… This means that all operations must execute successfully or, if an operation fails, all operations must revert to the previous state. This ensures that the data always remains consistent.

2. **Consistency:** If it was ok before, then it has to be too… This property guarantees that the transition from one state to another must always maintain data integrity. This means that if a transaction violates the integrity rules defined in the database, the transaction will roll back to its previous state.

3. **Isolation:** If things happen in parallel ways, they need to be isolated… This property ensures that transactions are executed in isolation from each other, so that the execution of a transaction does not affect the result of another transaction that is being executed simultaneously. This ensures that data remains consistent even when multiple transactions are running concurrently.

4. **Durability:** Last as long as necessary… This property guarantees that, after a transaction is successfully completed, the modified data will remain persistent in the database, even in case of system failure. This means that once changes have been made, they are permanent and will not be lost due to system crashes.

Why, I wrote **ACID** so many times?

For you not forgot

**Now repeat with me:** 
- **Atomicity:** Everything happens on nothing is considered

- **Consistency:** If it was ok before, after needs to be ok too

- **Isolation:** If things happen in parallel ways, they need to be isolated

- **Durability**: Last as long as necessary

Understanding this will take your understanding of relational databases and transactions to another level!