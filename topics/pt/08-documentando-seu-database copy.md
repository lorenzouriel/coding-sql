# Documentando o seu Database

Documentar um banco de dados costuma ser uma tarefa cansativa e repetitiva.

Quem já documentou, sabe. E quando muda algo no Schema, lá vamos nós atualizar a documentação ou o dicionário.

Porém, eu queria ter visto esse capítulo antes.

Hoje posso dizer que estou aqui para **documentar o seu banco de dados.**

Sabe aquela preguiça de criar um dicionário de dados? Ou de reescrever cada coluna especificando exatamente o que tem nela?

Isso acaba hoje!

Você vai fazer todo esse trabalho com apenas **dois comandos**

E quando tiver que atualizar? Apenas um comando...

Depois de acabar com a sua Task, você vai ficar me devendo um café.

## tbls - A ferramenta que vamos usar
Existe uma ferramenta Open Source para esse tipo de tarefa, já está um tempo no mercado, tem uma **documentação bem extensa e uma comunidade ativa.**

Você pode acessar a documentação dela [aqui](https://github.com/k1LoW/tbls?tab=readme-ov-file).

É importante destacar que ela é CI-Friendly, ou seja, para você que quer implementar um CI/CD no seu Database, é um bom ponto de partida.

Para utilizar, você vai precisar abrir o terminal.

Mas não se preocupe, nesse meu exemplo, vou rodar no Windows. O primeiro requisito é que você tenha o Docker instalado.

Outro requisito é ter um SGBD rodando localmenete ou acesso a um servidor e um banco de dados.

Estou rodando um Microsoft SQL Server localmente e o banco de dados que estou usando nesse exemplo é o mesmo do artigo de [Modelagem de Dados](/topics/pt/01-modelagem-de-dados.md). Pode utilizar também, se quiser praticar com o mesmo exemplo do artigo.

Essa **ferramenta conecta nos mais diversos tipos de bancos de dados**, alguns exemplos são:
- Microsoft SQL Server
- PostgreSQL
- SQLite
- MySql
- BigQuery
- Snowflake
- Amazon Redshift

E outros...

Nos nos conectamos usando um **DNS (Data Source Name)** com todas as **credenciais** necessárias para a conexão.

Esse é um exemplo **Microsoft SQL Server:**
```yml
dsn: sqlserver://DbUser:SQLServer-DbPassw0rd@hostname:1433/testdb
```

- `dsn`: Este é um identificador usado para conexões de dados (Data Source Name). Ele identifica a fonte de dados para a conexão.

- `sqlserver://`: Este é o protocolo usado para conectar ao SQL Server.

- `DbUser`: Este é o nome de usuário usado para autenticar a conexão com o banco de dados.

- `SQLServer-DbPassw0rd`: Esta é a senha associada ao usuário do banco de dados.

- `hostname`: Este é o endereço do servidor onde o SQL Server está sendo executado. Pode ser um endereço IP ou um nome de host.

- `1433`: Este é o número da porta padrão do SQL Server para conexões TCP/IP.

- `testdb`: Este é o nome do banco de dados ao qual se deseja conectar.

Todas as conexões seguem esse mesmo padrão, necessário alterar apenas o protocolo e a porta.

## Hora da Documentação (vai salvar o seu café da tarde)

O primeiro passo é instalar a aplicação, na documentação eles ensinam de várias maneiras e em vários SO. Porém, infelizmente, não tem nenhum exemplo no Windows. :(

Não que isso seja um problema, o **Docker corre em nossas veias aqui.** :)

Vamos realizar um `Docker pull` no próprio cmd. 
```docker
docker pull ghcr.io/k1low/tbls:latest
```

Depois de finalizar o Download, **você pode abrir o diretório em que você quer documentar a solução.**

O segundo passo é adicionar um `.yml` no diretório, o arquivo precisa ter esses nomes: `.tbls.yml` ou `tbls.yml`.

No `.yml` você vai **adicionar o seu DNS e o caminho para onde a documentação vai, no `docPath`**

**Segue exemplo:**
```yml
# .tbls.yml

# DSN (Database Source Name) to connect database
dsn: # .tbls.yml
dsn: sqlserver://DbUser:SQLServer-DbPassw0rd@hostname:1433/testdb

# Path to generate document
# Default is `dbdoc`
docPath: docs/schema
```

O terceiro e último passo é **rodar o comando para a criação da documentação**, aqui temos um truque por rodarmos no Docker.

Se você tivesse um SO igual foi destacado na documentação, você poderia rodar o comando `$ tbls doc` que a documentação já iria iniciar. 

Como estamos rodando no Docker, **vamos rodar o seguinte comando:** `docker run --rm -v ${PWD}:/work -w /work ghcr.io/k1low/tbls doc sqlserver://DbUser:SQLServer-DbPassw0rd@hostname:1433/testdb`

E a [mágica vai começar](https://www.youtube.com/watch?v=NAw7SqHnHLI)...

**Exemplo da resposta:**
![tbls_example](/topics/imgs/08-docs-database/tbls_example.png)

Temos **três arquivos principais** aqui:
- `README.md`: Um arquivo geral da documentação, nele você vai ter um overview completo do banco de dados.
- `tabela.md`: Um README.md para cada tabela, com as suas principais características
- `tabela.svg`: Uma imagem svg de cada tabela

Simplesmente, **esse é o resultado**:
![tbls_readme](/topics/imgs/08-docs-database/tbls_readme.png)

Por ser um README.md, **você pode complementar manualmente a documentação ou se aprofundar na documentação da ferramenta.** Ela oferece várias outras maneiras de **melhorar o seu README.md.**

Vai elevar o nível!