# Create a Low-Cost Data Warehouse / Crie um data warehouse de baixo custo

A minha ideia é realizar uma visão geral das etapas que um projeto desse nível possui, desde o levantamento de requisitos até a disponibilização de relatórios.

Esse artigo vai ser um guia para quando precisar relembrar os passos a serem seguidos.

Vou me inspirar em um projeto que fiz e disponibilizei no meu GitHub, nesse mesmo projeto fiz uma documentação extensa detalhando cada passo, são 45 páginas. 
- [Acesse o projeto aqui.](https://github.com/lorenzouriel/create-free-dw-and-olap-for-sales-analysis)

Outra fonte de inspiração foi o meu TCC, eu falei mais detalhadamento sobre cada etapa de um projeto desse tamanho.
- [Acesse o TCC aqui.](https://drive.google.com/file/d/171t6h2sQIhXhrqy69At5zC3UwRIofbWP/view?usp=sharing)

## Tópicos
1. Cenário, Requisitos e Objetivos
2. Modelagem Dimensional
3. Arquitetura de um BI 
4. Detalhes Sobre o Projeto

## Cenário, Requisitos e Objetivos
**O que é entender o cenário?**

Antes de iniciar um projeto de Business Intelligence (BI), é crucial entender o cenário no qual a empresa está inserida:
- **Contexto de Negócio:** Compreender o setor, mercado, concorrência e as tendências que afetam o negócio. Isso ajuda a identificar oportunidades e desafios que podem ser abordados pelo projeto de BI.

- **Estrutura Organizacional:** Conhecer a estrutura organizacional da empresa, incluindo departamentos, funções e processos-chave. Isso é essencial para identificar as principais áreas que podem se beneficiar dessas mudanças.

- **Processos de Negócio:** Mapear os principais processos de negócio para entender como os dados são gerados, coletados e utilizados atualmente.

Entender o cenário pode custar muito mais tempo que o próprio desenvolvimento do seu DW, pode ser um processo que vai ter acompanhar do ínicio ao fim. É importante ter um stakeholder engajado que entenda do assunto e possa colaborar com você.

**O que é definição de requisitos?**

A definição de requisitos é uma etapa que envolve a coleta de necessidades e expectativas dos stakeholders:
- **Identificação dos Stakeholders:** Determinar quem são os stakeholders (executivos, gerentes, analistas, etc.) e envolvê-los no processo de definição de requisitos.

- **Entrevistas e Workshops:** Realizar entrevistas e workshops com os stakeholders para entender suas necessidades de informação, desafios atuais e objetivos.

- **Documentação de Requisitos:** Documentar os requisitos coletados de forma clara e detalhada. Isso inclui os tipos de dados necessários, frequência de atualização, formatos de relatórios, dashboards desejados e métricas chave de desempenho (KPIs).

A partir dessa conversa já vamos ter uma ideia de quais são as nossas **fatos, métricas e dimensões**.

A partir do momento que levantamos os nossos requisitos, conseguimos ter uma ideia dos objetivos. Lembrando que o objetivo não é criar um Data Warehouse, **isso é só uma ação que está sendo realizada para atingir os objetivos**.

Toda vez que pensar em um objetivo pense em algo específico, mensurável e temporal. Resumindo, **tenha um prazo para atingi-lo e uma maneira de medir esse prazo x resultado.**

## Modelagem Dimensional
Na etapa acima, nós conseguimos recolher informações sobre os requisitos, fontes de dados e o principal: **As métricas**.

As nossas métricas serão as tabelas de fatos, essas tabelas de fatos vão ser criadas com o intuito de alimentar as métricas. Já as dimensões serão criadas com o intuito de analisar as métricas.

**Não ficou claro?**

Um fato é um evento que aconteceu em determinado momento, todo registro de ocorrência entra em uma fato. As fatos contêm métricas **quantitativas** que podem ser medidas e analisadas (por exemplo, quantidades, vendas, receitas, custos).

Dimensões são os contextos ou perspectivas a partir dos quais os fatos são analisados. Elas fornecem descrições **qualitativas** dos fatos. As dimensões Contêm dados descritivos ou categóricos (por exemplo, produto, tempo, localização). 

Uma maneira de pensar em suas dimensões é se questionando **como quero analisar essa informação?**. A partir dessa pergunta você vai conseguir imaginar diversas dimensões que podem ser criadas e aplicadas.

Sempre busque responder 04 perguntas quando pensar em tabelas de fatos:
- Onde? - (Localização, Empresa, Setor)
- Quando? - (Data, Hora)
- Quem? - (Vendedor, Gerente, Cliente)
- O quê? - (Produto)

E o que tudo isso tem a ver com modelagem dimensional?

A modelagem dimensional é justamente **como vamos relacionar e criar essas tabelas de fatos e dimensões.** É
nesse processo que vamos imaginar as diversas tabelas e fontes de dados coletadas e unificar tudo em um DW. 

Os principais esquemas de modelagem dimensional são:
- Esquema Estrela (Star Schema)
- Esquema Floco de Neve (Snowflake Schema)

É chamado de esquema estrela pois consiste em uma única tabela de fatos no centro, cercada por tabelas de dimensões.
- ![star_schema](/topics/imgs/10-dw/star_schema.jpg)

Já o esquema Floco de Neve temos uma característica em que as dimensões podem se dividir em múltiplas tabelas relacionadas.
- ![snow_flake](/topics/imgs/10-dw/snow_flake.jpg)


## Arquitetura de um BI
Antes de começar a ler, encare um pouco a arquitetura que abaixo:
- ![architecture](/topics/imgs/10-dw/architecture.jpg)

Bom, vamos destrinchar cada etapa dessa arquitetura.

**Fontes de Dados:**
- **Descrição:** Podem ser bancos de dados relacionais, arquivos, sistemas ERP, CRM, APIs externas, etc.
- **Função:** Fornecem os dados brutos que serão transformados e analisados.

**Camada de Integração (ETL):**
- **Descrição:** Ferramentas e processos que extraem dados das fontes, transformam os mesmos para garantir qualidade e consistência, e carregam-nos no data warehouse.
- **Função:**  Limpar, transformar e consolidar dados de várias fontes.

**Data Warehouse:**
- **Descrição:** Um repositório centralizado que armazena dados históricos e integrados.
- **Função:** Prover uma única fonte de verdade para a análise de dados.

**Data Marts:**
- **Descrição:** Subconjuntos do data warehouse focados em áreas específicas de negócios.
- **Função:** Otimizar o desempenho de consultas e análises específicas de departamentos.

**Criação de Cubos OLAP:**
- **Descrição:** Cubos OLAP (Online Analytical Processing) são estruturas de dados multidimensionais que permitem a análise rápida e eficiente de grandes volumes de dados.
- **Função:** Facilitar a análise multidimensional dos dados, permitindo operações complexas como drill-down, roll-up, slicing e dicing.

Crie um cubo OLAP se for realmente aplicável, na maioria dos projetos os data marts já são suficientes.

**Camada de Análise e Relatórios:**
- **Descrição:** Ferramentas de BI que permitem a criação de relatórios, dashboards e visualizações.
- **Função:** Analisar e apresentar dados de forma que suportem a tomada de decisões.

A etapa mais importante do B.I é entregar os relatórios para os stakeholders que os requisitam. Eles não querem saber da parte técnica, eles querem o ouro de tudo isso.

Nessa etapa é bom entender que existem três tipos de análises:
- **Ad-Hoc:** Fornece o OLAP de forma livre para o usuário.
- **Padronizada:** Para usuários que desejam flexibilidade no OLAP.
- **Customizada:** Usuários com interesses apenas nas informações dos relatórios.

### Principais Ferramentas 
Existem diversas ferramentas para cada uma das etapas do desenvolvimento de um DW. Vou listar as principais para que você se familiarize:

**1. Ferramentas de ETL (Extração, Transformação e Carga):**
- **Exemplos:** Talend, Informatica, Microsoft SQL Server Integration Services (SSIS), Apache Nifi.

**2. Data Warehousing:**
- **Exemplos:** Amazon Redshift, Google BigQuery, Snowflake, Microsoft Azure Synapse.

**3. Ferramentas de Análise de Dados:**
- **Exemplos:**  Microsoft Power BI, Tableau, QlikView, Looker.

**4. Ferramentas de Data Mining e Machine Learning:**
- **Exemplos:** RapidMiner, KNIME, SAS, Apache Spark MLlib.

**5. Ferramentas de Governança de Dados:**
- **Exemplos:** Microsoft Purview, Alation.

---
Recomendo que visite a documentação do projeto, existe um tutorial extenso sobre como cada etapa foi realizada. Atráves dele, você pode criar um novo projeto para o seu portfólio.

