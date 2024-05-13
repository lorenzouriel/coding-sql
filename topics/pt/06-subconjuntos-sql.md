# Subconjuntos SQL

Eles são separados em subconjuntos justamente para identificar com o que estamos lidando.
![subsets](/topics/imgs/06_subsets/subsets.png)

Por exemplo, se quisermos manipular dados, usamos DML (Data Manipulation Language).

**Cada subconjunto funciona com uma área específica do banco de dados.**

Vamos verificar os subconjuntos!

### Linguagem de definição de dados (DDL)
É um subconjunto de SQL que trata da definição ou modificação da estrutura de um esquema de banco de dados.

Instruções DDL são usadas para criar, modificar e excluir objetos de banco de dados, como tabelas, índices, visualizações e procedimentos armazenados.

**Instruções DDL:**
1. **CREATE:** Usado para criar novos objetos de banco de dados, como tabelas, visões, índices, etc.
```sql
CREATE TABLE [articles] ( 
    [id] int IDENTITY (1,1) PRIMARY KEY, 
    [name] VARCHAR(150), 
    [author] VARCHAR(50),
    [likes] int NULL
);
```

2. **ALTER:** Usado para modificar a estrutura de objetos de banco de dados existentes.
```sql
ALTER TABLE [articles]
ADD COLUMN [views] int NULL
```

3. **DROP:** Usado para excluir objetos de banco de dados existentes.
```sql
DROP TABLE [articles]
```

4. **TRUNCATE:** Usado para remover todos os registros de uma tabela mantendo a estrutura da tabela.
```sql
TRUNCATE TABLE [articles]
```

### Linguagem de Manipulação de Dados (DML)
É um subconjunto do SQL usado para manipular dados armazenados em um banco de dados.

O DML está focado em tarefas como consultar, inserir, atualizar e excluir dados dentro das tabelas.

**Instruções DML:**
1. **SELECT:** Recupera dados de uma ou mais tabelas com base em critérios específicos.
```sql
SELECT * FROM [articles] WHERE [views] >= 1
```

2. **INSERT:** Usado para adicionar novas linhas de dados a uma tabela.
```sql
INSERT INTO [articles] (name, author) 
VALUES ('The SQL Week: SQL Subsets', 'Lorenzo Uriel');
```

3. **UPDATE:** Usado para modificar dados existentes dentro de uma tabela.
```sql
UPDATE [articles] 
SET [views] = 1
WHERE [name] = 'The SQL Week: SQL Subsets'
```

4. **DELETE:** Usado para remover linhas de dados de uma tabela com base em condições específicas.
```sql
DELETE FROM [articles] 
WHERE [name] = 'The SQL Week: SQL Subsets'
```

Há muita discussão aqui, alguns dizem que SELECT faz parte do DML, outros que ele faz parte do DQL.

Mas fiz algumas pesquisas na documentação do Microsoft SQL Server e boom: **SELECT faz parte do DML.**

DQL nem mesmo existe na documentação, se SQL é uma linguagem de consulta por si só, por que DQL existiria?

*Loucura, não é mesmo?*

### Linguagem de Controle de Dados (DCL)
Esses são basicamente controles de acesso, com eles você pode conceder ou bloquear acesso.

**Instruções DCL:**

1. **GRANT:** Concede permissões a um usuário ou função
```sql
GRANT SELECT ON [articles] TO [user]
```

2. **REVOKE:** Revoga permissões designadas pelo GRANT
```sql
REVOKE SELECT ON [articles] TO [user]
```

3. **DENY:** egativa explicitamente permissões a um usuário ou função
```sql
DENY DELETE ON [articles] TO [user]
```

### Linguagem de Transação de Dados (DTL)
É um subconjunto do SQL usado para gerenciar transações dentro de um banco de dados.

Em um banco de dados relacional, quase tudo é uma transação, esses comandos são mais usados em um contexto de transações explícitas - onde o desenvolvedor define explicitamente a estrutura de uma transação.

**Instruções DTL:**
1. **BEGIN TRANSACTION:** Inicia uma nova transação. Todas as instruções SQL subsequentes fazem parte desta transação até que ela seja confirmada ou revertida.
```sql
BEGIN TRANSACTION;
-- SQL statements here will be part of the transaction

-- For example:
UPDATE [articles] 
SET [views] = 1
WHERE [name] = 'The SQL Week: SQL Subsets'
```

2. **COMMIT TRANSACTION:** Salva todas as alterações feitas durante a transação atual no banco de dados.
```sql
BEGIN TRANSACTION;
-- SQL statements here will be part of the transaction

-- For example:
UPDATE [articles] 
SET [views] = 1
WHERE [name] = 'The SQL Week: SQL Subsets'

COMMIT TRANSACTION;
```

3. **ROLLBACK TRANSACTION:** Desfaz todas as alterações feitas durante a transação atual.
```sql
BEGIN TRANSACTION;
-- SQL statements here will be part of the transaction

-- For example:
UPDATE [articles] 
SET [views] = 1
WHERE [name] = 'The SQL Week: SQL Subsets'

ROLLBACK TRANSACTION;
```

4. **SAVE TRANSACTION:** Define um ponto de salvamento dentro da transação ao qual você pode voltar posteriormente.
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

### Quais são os próximos passos?
Salve o conteúdo, crie um exemplo de banco de dados e comece a praticar. É a melhor maneira de aprender! 

Se tiver alguma dúvida, entre em contato.