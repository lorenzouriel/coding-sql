# Modelagem de Dados
Quem me conhece sabe que eu gosto de desenhar e seguir processos, acredito que esse é o Core para resolver qualquer problema.

Ter uma boa documentação e um processo bem definido, vai te deixar mais confiante para aplicar e criar algo.

E um dos processos que mais amo, é o de Modelagem de Dados. É sério, tipo de trabalho que faço ouvindo uma música de tão prazeroso que é.

E no que consiste o processo de modelagem?

### Podemos citar:
1. Análise de Rquisitos
2. Modelo Conceitual (DER - MER)
3. Modelo Lógico (Tabelas e Relacionamentos)
4. Modelo Físico (Criação das tabelas no banco)**

Esses serão os tópicos deste capítulo, e, no final, quero construir um exemplo real com vocês, do zero.


## Análise de Requisitos
A análise de requisitos é a fase inicial e fundamental no processo de modelagem de dados. É o conselho que mais vemos no nosso querido LinkedIn -> **comunicação, meus amigos!**

Essa etapa envolve a compreensão e documentação das necessidades do usuário e do sistema, a identificação dos dados relevantes e a definição dos requisitos funcionais e não funcionais do sistema. 

Crucial para garantir que o modelo de dados seja construído de forma a atender às expectativas e necessidades dos stakeholders.

**Etapas para analisar os requisitos:**
1. **Entendimento do problema:** Compreensão detalhada do contexto do sistema, seus objetivos e restrições.

2. **Coleta de requisitos:** Coleta de informações sobre os requisitos.

3. **Análise e documentação:** Análise dos requisitos coletados para identificar inconsistências e documentação detalhada dos requisitos.

4. **Validação de Requisitos:** Essa etapa conversa muito com a próxima, só quando criamos os relacionamentos e diagramas que sentimos falta de alguns requisitos.

A ideia aqui é a participação ativa dos stakeholders para garantir que as necessidades do negócio sejam adequadamente capturadas e traduzidas em requisitos de dados. 

Ele não precisa saber qual vai ser o tipo do campo [name], mas é bom confirmar com ele se o campo [name] é realmente necessário.


## Modelo Conceitual (DER - MER)
É criado por meio de diagramas como o **DER (Diagrama de Entidade-Relacionamento) ou o MER (Modelo Entidade-Relacionamento).** 

Esses diagramas **ajudam a visualizar as entidades, seus atributos e os relacionamentos entre elas de uma maneira abstrata, sem considerar detalhes de implementação.**

Para entendermos para que serve um modelo conceitual, vamos entender alguns pontos importantes antes:
- Entidades
- Relacionamentos 
- Cardinalidades
- Atributos

### Entidades
Quem programa ou já programou sabe que uma **entidade** é um **objeto do mundo real.** Para simplificar ainda mais, ela é a nossa **tabela.**


Ela pode ser **abstrata** ou **completa:**
- *Uma **entidade abstrata** é um conceito geral, que não possui características específicas definidas.*

- *Uma **entidade completa**, por outro lado, é uma instância específica de uma entidade abstrata, com características distintas e bem definidas.*

As entidades são representadas em modelos retangulares:
- ![entity](/topics/imgs/01_data_modelling/e.png)

Existem dois tipos de entidades, as **fortes** e as **fracas**:

- **Fortes:** Não depende da existência de outra entidade.

- **Fracas:** Depende de uma outra entidade proprietária. Essas são representadas com dois retângulos.
    - ![entity](/topics/imgs/01_data_modelling/ef.png)


### Relacionamentos
São basicamente **como as entidades conversam e se relacionam entre si.**
- ![relationship](/topics/imgs/01_data_modelling/relationships.png)

Os graus de relacionamentos são:

**1. Relacionamento Binário:** Duas entidades participam de um relacionamento.
- ![relationship](/topics/imgs/01_data_modelling/relationships.png)


**2. Relacionamento Ternário:** Onde três entidades participam de um relacionamento. 
- ![relationship](/topics/imgs/01_data_modelling/relationships_ter.png)


**3. Relacionamento N-ário:** Onde quatro ou mais entidades participam de um relacionamento.
- ![relationship](/topics/imgs/01_data_modelling/relationships_nario.png)


E é nesses relacionamentos que definimos as **cardinalidades.**

### Cardinalidade
A cardinalidade refere-se ao **número de ocorrências de uma entidade que estão relacionadas a outra entidade através de um relacionamento.**

Existem dois tipos principais de cardinalidades:
- **Cardinalidade Mínima:** Indica o número mínimo de ocorrências de uma entidade que devem estar relacionadas a outra entidade.

- **Cardinalidade Máxima:** Indica o número máximo de ocorrências de uma entidade que podem estar relacionadas a outra entidade.

**Notações de Cardinalidade:**
- **(0,1):** Zero ou uma ocorrência.
- **(1,1):** Exatamente uma ocorrência.
- **(0,N):** Zero ou mais ocorrências.
- **(1,N):** Uma ou mais ocorrências.

Como nessa etapa existe bastante confusão, eu vou dar alguns exemplos:
- **1,1 (Um para Um):** Um cliente tem exatamente um endereço e um endereço pertence a apenas um cliente.

- **1,N (Um para Muitos):** Um departamento pode ter muitos funcionários, mas um funcionário só pode pertencer a um departamento.

- **N,M (Muitos para Muitos):** Um aluno pode se matricular em muitos cursos e um curso pode ter muitos alunos matriculados. Isso é geralmente modelado usando uma tabela de junção.

***Curiosidade:** Cardinalidade eu aprendi no 01 semestre da faculdade e só fui usar de verdade quase 01 ano após me formar.*


### Atributos
Os atributos nada mais são do que as **características de uma entidade**, ou seja, os seus **campos.**

São representados como extensões no retângulos:
- ![attributtes](/topics/imgs/01_data_modelling/atributtes.png) 

Os tipos de atributos são:

- **Atômicos:** Único e indivisível. 
    - Exemplos são: CPF, CNPJ

- **Compostos:** Pode ser divido em partes menores
    - Exemplos são: Endereço, Nome

- **Multivalorado:** Pode ter N valores associados a ele
    - Exemplos são: Números, celulares

- **Derivados:** Depende de outro atributo ou outra entidade
    - Exemplos são: Idade -> Data de Nascimento 

- **Chave:** Utilizado como identificador
    - Exemplos são: PKs e FKs

Com esses conceitos podemos criar o nosso **modelo conceitual**, ele nada mais é que uma **representação de alto nível das entidades e seus relacionamentos em um domínio de negócios.** 

O nosso banco de dados é um de **rastreamento de hábitos**, eu deixei o modelo conceitual sem os atributos especificados. Apenas as **entidades, relacionamentos e cardinalidade.**
- ![conceptual_model](/topics/imgs/01_data_modelling/conceptual_model.png) 


## Modelo Lógico (Tabelas e Relacionamentos):
O Modelo Lógico é uma **representação mais detalhada do banco de dados, que traduz o modelo conceitual em termos mais próximos da implementação física.** A modelagem lógica **não inclui índices e constraints**, apenas a **representação das tabelas e seus relacionamentos.**

Ele descreve as tabelas, seus atributos e os relacionamentos entre elas de uma maneira mais concreta, usando linguagens de modelagem de dados como o Modelo Relacional. 

Nesta fase, as **entidades do DER/MER são mapeadas para tabelas, os atributos são mapeados para colunas e os relacionamentos são mapeados para chaves estrangeiras.** 

O modelo lógico serve como uma base para a implementação do banco de dados e é utilizado para projetar consultas e transações.

- ![logical_model](/topics/imgs/01_data_modelling/logical_model.png) 

## Modelo Físico (Criação das tabelas no banco):
O Modelo Físico é a **implementação concreta do banco de dados, que envolve a criação real das tabelas e outros objetos no banco de dados conforme definido no modelo lógico.**

Ele descreve como os dados serão armazenados e acessados fisicamente no banco de dados, **incluindo detalhes como tipos de dados, índices, restrições de integridade e partições.**

O modelo físico é específico para o sistema de gerenciamento de banco de dados (SGBD) escolhido e é frequentemente criado usando **SQL (Structured Query Language)** ou ferramentas de modelagem de banco de dados. 

É nessa fase que criamos as documentações como um dicionários de dados e adicionamos os nossos schemas em um repositório.

Com isso, seu projeto vai para outro nível!

Exemplo do diagrama como um modelo físico:
- ![physical_model](/topics/imgs/01_data_modelling/physical_model.png) 

Uma outra maneira de representar esse modelo físico é com os **scripts SQL de criação das tabelas.** Exemplos:
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

Seguir esse processo e documentar são boas práticas relacionados ao processo de modelagem. Tenha sempre em mente para que serve um processo e porque ele deve ser respeitado.

#### Para fechar...

Encontrei essa tabela que faz um resumão das diferenças entre os modelos:
- ![types](/topics/imgs/01_data_modelling/table_types_of_modelling.png) 
