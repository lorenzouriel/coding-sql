# Joins
Claro que você já ouviu falar dos **tipos de joins**

Quero destacar os pontos principais entre os joins existentes e dar exemplos de seus usos

A ideia é abordar vários tópicos sobre SQL e joins é um deles, muito importante para sua vida diária usando SQL

![joins](/topics/imgs/07-joins/types_joins.png)

- *Usaremos o banco de dados que criamos no [artigo de modelagem de dados](/topics/pt/01-modelagem-de-dados.md)*


## INNER JOIN
Recupera registros **de ambas as tabelas onde há uma correspondência com base na condição especificada.** Se não houver registro correspondente em qualquer uma das tabelas, as linhas não aparecerão no conjunto de resultados.

Um INNER JOIN é o tipo mais comum de join em SQL, tenho certeza de que você já fez pelo menos uma vez.

Ele combina linhas de duas tabelas com base em uma coluna relacionada entre elas, você precisa de um campo que exista em ambas as tabelas.

O conjunto de resultados contém apenas as linhas para as quais a condição de junção é verdadeira em ambas as tabelas, se o `id` for órfão, provavelmente há algo errado com suas tabelas.

Para **INNER JOIN você pode escrever apenas JOIN.**

**Exemplo de INNER JOIN:**
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

**Resultado:**
- ![inner_join](/topics/imgs/07-joins/inner_join.png)

Nesse exemplo **estou realizando o join para identificar o nome e a descrição de cada hábito praticada nas datas.**

## LEFT JOIN (ou LEFT OUTER JOIN)
Recupera todos os registros **da tabela esquerda e os registros correspondentes da tabela direita.** 

Se não houver correspondência na tabela direita, valores NULL são retornados para as colunas da tabela direita.

LEFT JOIN é **útil quando você deseja recuperar todos os registros da tabela esquerda, independentemente de haver ou não um registro correspondente na tabela direita.**

**Exemplo de LEFT JOIN:**
```sql
SELECT 
	*
FROM old_habits oh
LEFT JOIN habits h ON (h.id = oh.[id])
```
- ***Obs:** Para este exemplo, criei outra tabela semelhante a `habits` e adicionei mais duas linhas*

**Resultado:**
- ![left_join](/topics/imgs/07-joins/left_join.png)


## RIGHT JOIN (ou RIGHT OUTER JOIN):
É semelhante a um LEFT JOIN, mas **recupera todos os registros da tabela direita e os registros correspondentes da tabela esquerda.** 

Se não houver correspondência na tabela esquerda, valores NULL são retornados para as colunas da tabela esquerda.

RIGHT JOIN é **menos comumente usado do que LEFT JOIN, mas pode ser útil em determinadas situações, especialmente quando você deseja se concentrar nos dados da tabela direita.**

**Exemplo de RIGHT JOIN:**
```sql
SELECT 
     oh.[name], 
     h.[name] 
FROM habits h
RIGHT JOIN old_habits oh ON (h.id = oh.[id])
```

**Resultado:**
- ![right_join](/topics/imgs/07-joins/right_join.png)


## FULL JOIN (ou FULL OUTER JOIN)
Recupera todos os registros **quando há uma correspondência na tabela esquerda ou direita.** 

Se não houver correspondência, **valores NULL são retornados para as colunas da tabela sem uma linha correspondente.**

FULL JOIN é útil quando você deseja **recuperar todos os registros de ambas as tabelas e ver onde eles correspondem ou não.**

**Exemplo de FULL JOIN:**
```sql
SELECT 
	*
FROM tracking tr
FULL JOIN time t ON (tr.[date] = t.[date])
```

**Resultado:**
- ![full_join](/topics/imgs/07-joins/full_join.png)

Aqui estou criando uma linha do tempo nesses dados, **consigo analisar todos os dias que um hábito foi realizado e os dias que não.**

## CROSS JOIN
Retorna o produto cartesiano das duas tabelas, **combinando cada linha da primeira tabela com cada linha da segunda tabela.**

Ao contrário de outros joins, **não requer nenhuma condição a ser atendida.**

CROSS JOIN **gera um conjunto de resultados com o número total de linhas igual ao produto do número de linhas em cada tabela.**

Pode ser útil para **gerar combinações de dados**, mas também pode **resultar em conjuntos de resultados muito grandes se as tabelas envolvidas forem grandes.**

**Exemplo de CROSS JOIN:**
```sql
SELECT 
	*
FROM tracking tr
CROSS JOIN contacts
```

**Resultado:**
- ![cross_join](/topics/imgs/07-joins/cross_join.png)

Agora, vou inserir outro contato

- ![cross_join_2](/topics/imgs/07-joins/cross_join_2.png)

Isso é alcançado combinando cada linha da tabela `habits` com cada linha da tabela `contacts`, **resultando em um produto cartesiano das duas tabelas.**

De fato, **INNER JOIN é o mais usado em consultas SQL.**

Pessoalmente, **tendo a recorrer aos JOINs LEFT e RIGHT quando estou aprofundando a análise de dados, muitas vezes para examinar a presença ou ausência de valores, LEFT para validação de dados é ouro, meus amigos!**

**FULL JOIN**, por outro lado, é reservado para cenários como o descrito acima - **instâncias em que precisamos correlacionar com uma linha do tempo abrangente.** 

Quanto ao **CROSS JOIN**, ele não é normalmente usado, **apenas para fins específicos, como anexar uma assinatura a cada linha.**


## Bônus: Union vs. Union All
Tanto **UNION** quanto **UNION ALL** são usados para **combinar resultados de duas ou mais consultas em uma única lista de resultados.** No entanto, eles têm diferenças importantes em seu comportamento:

### UNION
Combina os resultados de duas ou mais consultas em uma única lista de resultados. **Ele remove automaticamente quaisquer duplicatas que possam surgir entre as consultas.**

É útil quando você deseja **combinar resultados de várias consultas e garantir que não haja duplicatas nos resultados finais.**

Use **UNION** quando você deseja eliminar duplicatas e produzir um conjunto de resultados único.

**Exemplo de UNION:**
```sql
SELECT 
	*
FROM [tracking_habits].[dbo].[habits]

UNION

SELECT 
	*
FROM [tracking_habits].[dbo].[old_habits]
```

**Resultado:**
- ![union](/topics/imgs/07-joins/union.png)

### UNION ALL
Combina os **resultados de duas ou mais consultas em uma única lista de resultados.** No entanto, ao contrário do UNION, ele não remove duplicatas - **simplesmente combina todos os resultados, incluindo duplicatas, se houver.**

É mais rápido que o UNION, pois não precisa verificar e eliminar duplicatas.

Use **UNION ALL** quando você deseja combinar todos os resultados, incluindo duplicatas, ou quando tem certeza de que não haverá duplicatas e deseja melhor desempenho.

**Exemplo de UNION ALL:**
```sql
SELECT 
	*
FROM [tracking_habits].[dbo].[habits]

UNION ALL

SELECT 
	*
FROM [tracking_habits].[dbo].[old_habits]
```
**Resultado:**
- ![union_all](/topics/imgs/07-joins/union_all.png)


### Quais são os próximos passos?
Salve o conteúdo, crie um exemplo de banco de dados e comece a praticar. É a melhor maneira de aprender! 

Se tiver alguma dúvida, entre em contato.
