# Álgebra Relacional e SQL

**O que é álgebra relacional?**
A álgebra relacional é uma forma teórica de manipular dados em um banco de dados relacional. Não houve muita atenção a esse assunto até a publicação do modelo relacional por Edgar F. Codd, **na publicação do modelo relacional, Edgar propõe que a álgebra seja usada como base para linguagens de consulta de banco de dados.**

A álgebra relacional permite realizar operações de consulta e manipulação de dados, tais como:
- seleção
- projeção
- união
- diferença
- produto cartesiano
- junções.

Essas operações são baseadas em conjuntos matemáticos e são aplicadas a relações que representam as tabelas e dados em um banco de dados relacional.

Podemos dizer que **SQL é uma linguagem de consulta de banco de dados derivada da álgebra relacional.**

**O que compõe a álgebra relacional?**
A álgebra relacional é composta por Teoria dos Conjuntos e algumas operações específicas. Podemos falar sobre:

**1. Relacionamentos:** Os relacionamentos são representados por tabelas que armazenam dados em um banco de dados relacional. Cada relação é composta por tuplas (`linhas`) e atributos (`colunas`). (Neste campo matemático, chamaremos as linhas de tuplas e as colunas de atributos)

**2. Operadores Básicos:**
- **Seleção (σ):** filtra as tuplas de uma relação com base em uma condição específica.
- **Projeção (π):** seleciona determinadas colunas de uma relação, descartando as outras.

**3. Teoria dos Conjuntos:**
- **União (∪):** combina duas relações, retornando todas as tuplas distintas.
- **Interseção (∩):** retorna as tuplas comuns a duas relações.
- **Diferença (-):** Retorna as tuplas que estão em uma relação, mas não na outra.

Para representar a teoria dos conjuntos visualmente, usamos o [Diagrama de Venn](https://medium.com/@lorenzouriel/relational-algebra-e-sql-47e0972460f1#:~:text=Venn%20Diagram.%20Example%3A-,Venn%20Diagram,-4.%20Combination).

**4. Operadores de Combinação:**
- **Produto Cartesiano (×):** Também conhecido como "junção cruzada", o produto cartesiano combina todas as tuplas de duas relações. O resultado é uma nova relação que contém todas as combinações possíveis de tuplas das duas relações de entrada. Por exemplo, se a primeira relação tiver m tuplas e a segunda relação tiver n tuplas, o produto cartesiano terá m x n tuplas.

- **Join (⨝):** A junção combina tuplas de duas ou mais relações com base em uma condição de junção. A condição de junção é especificada para comparar os valores de atributo nas relações envolvidas. Existem diferentes tipos de junção:

    - **Inner Join:** Retorna as tuplas que têm valores correspondentes nas relações de junção.
    - **Outer Join:** Retorna as tuplas correspondentes além das tuplas não correspondentes em uma ou ambas as relações de junção.
    - **Left Join:** Retorna todas as tuplas da primeira relação de junção e as tuplas correspondentes da segunda relação de junção.
    - **Right Join:** Retorna todas as tuplas da segunda relação de junção e as tuplas correspondentes da primeira relação de junção.
    - **Full Join** Retorna todas as tuplas de ambas as relações de junção, combinando as correspondentes e preenchendo com valores nulos quando não houver correspondência.

Vamos cobrir mais sobre junções em um próximo capítulo!
