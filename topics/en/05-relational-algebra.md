# Relational Algebra and SQL
**What is relational algebra?**
Relational algebra is a theoretical way of manipulating data in a relational database. There was not much attention on this subject until the publication of the relational model by Edgar F Codd, **in the publication of the relational model Edgar proposes that algebra be used as a basis for database query languages.**

Relational algebra allows you to perform query operations and data manipulation, such as:
- selection
- projection
- union
- difference
- Cartesian product
- joins. 

These operations are based on mathematical sets and are applied to relationships that represent the tables and data in a relational database.

We can say that **SQL is a database query language derived from relational algebra.**

**What makes up relational algebra?**
Relational algebra is composed by Set Theory and some specific operations. We can talk about:

**1. Relationships:** Relationships are represented by tables that store data in a relational database. Each relation is composed of tuples (`rows`) and attributes (`columns`). (In this mathematical field we will call rows tuples and columns attributes)

**2. Basic Operators:**
- **Selection (σ):** filters the tuples of a relation based on a specific condition.
- **Projection (π):** selects certain columns of a relation, discarding the others.

**3. Set Theory:**
- **Union (∪):** combines two relations, returning all distinct tuples.
- **Intersection (∩):** returns the tuples common to two relations.
- **Difference (-):** Returns tuples that are in one relation but not in the other.

To represent set theory visually we use the [Venn Diagram](https://medium.com/@lorenzouriel/relational-algebra-e-sql-47e0972460f1#:~:text=Venn%20Diagram.%20Example%3A-,Venn%20Diagram,-4.%20Combination).

**4. Combination Operators:**
- **Cartesian product (×):** Also known as a “cross join”, the Cartesian product combines all tuples of two relations. The result is a new relation that contains all possible combinations of tuples from the two input relations. For example, if the first relation has m tuples and the second relation has n tuples, the Cartesian product will have m x n tuples.

- **Join (⨝):** Join combines tuples from two or more relations based on a join condition. The join condition is specified to compare the attribute values in the involved relationships. There are different types of join:

    - **Inner Join:** Returns the tuples that have matching values in the join relations.
    - **Outer Join:** Returns matching tuples in addition to non-matching tuples in one or both of the join relations.
    - **Left Join:** Returns all tuples from the first join relation and the corresponding tuples from the second join relation.
    **- Right Join:** Returns all tuples from the second join relation and the corresponding tuples from the first join relation.
    - **Full join:** Returns all tuples from both join relations, combining matching ones and padding with null values when there is no match.

We will cover more about joins in a next chapter!