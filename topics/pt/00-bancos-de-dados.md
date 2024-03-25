# SQL
Antes de começarmos com os tópicos e explicações, vamos entender o significado dessas três letras?

**SQL = Linguagem de Consulta Estruturada**

O SQL é considerado estruturado porque **segue uma sintaxe e padrão específicos em seus comandos.**

Isso facilita o aprendizado e estabelece um padrão de como consultar o banco de dados.

Em outras palavras, existe uma maneira estruturada de resolver um desafio.

Se houver um problema ou tarefa, **os usuários podem usar comandos estruturados para resolvê-lo.**

E Consulta, bem, basicamente consultamos tudo em um banco de dados.

**O SQL não é uma linguagem de programação, é uma Linguagem de Consulta Estruturada**

#### Por que devo aprender SQL?

Bem...

![meme-sql](/topics/imgs/00_databases/sql-meme.jpg)


# Bancos de Dados
Um banco de dados relacional **representa dados de maneira estruturada, organizada em tabelas compostas por linhas e colunas.**

Cada **tabela dentro do banco de dados contém dados relacionados a uma entidade ou conceito específico.**

- Por exemplo, em um banco de dados para uma empresa, você pode ter tabelas para funcionários, departamentos e projetos.

As **colunas dentro de uma tabela definem os atributos ou propriedades dos dados armazenados.** Cada coluna tem um nome e um tipo de dados, especificando o tipo de informação que pode ser armazenado, como inteiros, strings, datas ou dados binários.

- Por exemplo, em uma tabela de funcionários, você pode ter colunas para ID do funcionário, nome, cargo, ID do departamento e data de contratação.

**As linhas, também conhecidas como registros ou tuplas, representam instâncias individuais de dados dentro da tabela.** Cada linha contém um conjunto de valores correspondentes às colunas definidas na tabela.

- Continuando com o exemplo de uma tabela de funcionários, cada linha representaria um funcionário único e conteria informações específicas sobre esse funcionário, como seu ID, nome, cargo, etc.

Uma das características-chave de um banco de dados relacional é o estabelecimento de relacionamentos entre tabelas. **Esses relacionamentos definem como os dados em uma tabela estão relacionados aos dados em outra.** Os relacionamentos são **geralmente estabelecidos usando chaves, como chaves primárias e chaves estrangeiras.**

- A chave primária identifica de forma única cada registro em uma tabela.
- A chave estrangeira estabelece um link entre duas tabelas, referenciando a chave primária de outra tabela.

No geral, **a estrutura tabular de um banco de dados relacional, juntamente com os relacionamentos entre tabelas, fornece uma maneira flexível e eficiente de organizar e gerenciar grandes volumes de dados.**

Essa estrutura permite consultas, recuperação e manipulação de dados fáceis, tornando os bancos de dados relacionais uma escolha popular.

***Bancos de Dados -> Tabelas (Relacionamentos) -> Colunas -> Linhas***
![tables_and_columns](/topics/imgs/00_databases/tables_and_columns.png)


## RDBMS vs. SGBD
**Sistema de Gerenciamento de Banco de Dados Relacional (RDBMS):**

Um RDBMS é um tipo específico de SGBD que é **baseado no modelo de dados relacional.**

Ele organiza dados em tabelas relacionadas, onde os relacionamentos entre dados são estabelecidos usando chaves.

As principais características de um RDBMS incluem:

1. **Modelo Relacional:** Os dados são organizados em tabelas com linhas e colunas, seguindo o modelo relacional.

2. **Integridade Referencial:** O RDBMS suporta integridade referencial, garantindo que os relacionamentos entre tabelas sejam mantidos consistentemente.

3. **Operações ACID:** As transações em um RDBMS são ACID (Atomicidade, Consistência, Isolamento e Durabilidade), garantindo confiabilidade e consistência dos dados.

4. **SQL:** Os RDBMS geralmente suportam SQL (Structured Query Language) como a linguagem de consulta padrão para interagir com o banco de dados.

**Exemplos:**
- Microsoft SQL Server
- Oracle Database
- PostgreSQL
- MySQL


**Sistema de Gerenciamento de Banco de Dados (SGBD):**
Refere-se a qualquer tecnologia para gerenciar bancos de dados, independentemente do modelo de dados subjacente. Isso inclui não apenas RDBMS, mas também outros tipos de sistemas de gerenciamento de banco de dados, como bancos de dados orientados a documentos, bancos de dados de séries temporais, bancos de dados de grafos, etc.


## T-SQL vs. PL/SQL vs. PL-PgSQL
Você lê muito sobre T-SQL e PL/SQL em descrições de empregos?

Esses são dialetos usados para determinar em qual plataforma o SQL será aplicado...

Por exemplo:

- **Transact-SQL (T-SQL):** Esta versão do SQL é usada pelo Microsoft SQL Server e pelos serviços Azure SQL da Microsoft.

- **Linguagem Procedural/SQL (PL/SQL):** Isso é usado pela Oracle.

Não para por aí. Temos mais um exemplo, o PostgreSQL também tem o seu próprio:

- **Linguagem Procedural - Postgree/SQL (PL-PgSQL):** Extensões implementadas no PostgreSQL.

No final, a lógica é a mesma, mas você pode encontrar algumas diferenças em sua sintaxe!

## Bônus: Baixar SQL Server com PowerShell

Pensei em adicionar um **tópico apenas cobrindo um guia de instalação do SQL Server**. Mas vemos isso em todos os lugares. Vou fazer melhor aqui. Vou **automatizar a instalação e configuração do seu SQL Server**. Sim, você nunca mais precisará se preocupar com o Assistente novamente. Basta abrir o seu Power Shell ISE e executar os scripts abaixo.

### Script 01 - Instalando o SQL Server

```powershell
$isoPath = "$env:C:\SQLServer2019-x64-ENU-Dev.iso"
$driveLetter = "D"

Write-Host "Abrindo diretório ISO..."
Invoke-Item -Path $isoPath 

Write-Host "Aguardando abertura do diretório ISO..."
Start-Sleep -Seconds 5

$extractPath = $driveLetter + ":" 

Write-Host "Instalando..."
cmd /c start /wait $extractPath\setup.exe /q /ACTION=Install /FEATURES=SQLEngine,FullText,RS,IS /INSTANCENAME=MSSQLSERVER /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" /TCPENABLED=1 /SECURITYMODE=SQL /SAPWD=Password12! /IACCEPTSQLSERVERLICENSETERMS

Write-Host "Dismontando ISO..."
Dismount-DiskImage -ImagePath $isoPath

Write-Host "OK"
```

***Este script em PowerShell foi projetado para automatizar a instalação do SQL Server 2019 usando um arquivo ISO. Vamos analisar o script passo a passo:***

**1. Definindo Variáveis:**
   
   - `$isoPath`: Caminho para o arquivo ISO do SQL Server.
   
   - `$driveLetter`: Letra da unidade onde o ISO será montado.

**2. Abrindo Diretório ISO:** Abre o diretório onde o arquivo ISO está localizado.

**3. Aguardando Abertura do Diretório ISO:** Pausa a execução por 5 segundos para permitir que o diretório ISO seja aberto.

**4. Caminho de Extração:** Especifica o caminho onde o ISO será montado, combinando a letra da unidade e dois pontos (por exemplo, "D:").

**5. Instalando o SQL Server:**

   - Executa o setup do SQL Server em modo silencioso (`/q`).
   
   - Especifica as ações de instalação (`/ACTION=Install`).
   
   - Especifica os recursos a serem instalados (`/FEATURES=SQLEngine,FullText,RS,IS`).
   
   - Define o nome da instância (`/INSTANCENAME=MSSQLSERVER`).
   
   - Define as contas de administrador do sistema do SQL Server (`/SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS"`).
   
   - Habilita o protocolo TCP (`/TCPENABLED=1`).
   
   - Define o modo de segurança para SQL (`/SECURITYMODE=SQL`).
   
   - Especifica a senha do administrador do sistema do SQL Server (`/SAPWD=Password12!`).
   
   - Aceita os termos de licença do SQL Server (`/IACCEPTSQLSERVERLICENSETERMS`).

**6. Desmontando ISO:** Desmonta o arquivo ISO.

**7. Saída "OK":** Indica a conclusão bem-sucedida do script.

### Script 02 - Download SQL Server
```powershell
Write-Host "Downloading SQL Server 2019..."
$isoPath = "$env:C:\SQLServer2019-x64-ENU-Dev.iso"
(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/7/c/1/7c14e92e-bdcb-4f89-b7cf-93543e7112d1/SQLServer2019-x64-ENU-Dev.iso', $isoPath)
```

**1. Write-Host "Downloading SQL Server 2019...":**
   - Esta linha simplesmente exibe uma mensagem no console para indicar que o processo de download está iniciando.

**2. $isoPath = "$env:C:\SQLServer2019-x64-ENU-Dev.iso":**
   - Aqui, estamos definindo a variável $isoPath para armazenar o caminho onde o arquivo ISO baixado será salvo. $env:C: é uma variável de ambiente que se refere à unidade C no Windows.

**3. (New-Object Net.WebClient).DownloadFile('URL', $isoPath):**
   - Esta linha inicia o download do arquivo ISO do SQL Server 2019 a partir da URL especificada. Ele usa o método DownloadFile da classe WebClient para baixar o arquivo e salvá-lo no local especificado por $isoPath.
