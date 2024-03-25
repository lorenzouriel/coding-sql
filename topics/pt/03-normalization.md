# Normalização
Consiste em técnicas usadas para evitar inconsistência e redundância de dados por meio da estruturação do banco de dados. É um conjunto de regras e técnicas que ajudam a projetar e organizar a estrutura de um banco de dados relacional de forma eficiente.
- **Inconsistência:** A normalização ajuda a manter a consistência dos dados, pois as alterações em uma tabela são automaticamente refletidas em outras tabelas relacionadas. Isso evita problemas de inconsistência e garante a **integridade referencial.**
- **Redundância:** Evita a repetição desnecessária de dados em diferentes partes do banco de dados, o que economiza espaço de armazenamento e reduz a probabilidade de inconsistências.

Podemos destacar alguns **benefícios** como:
- Semântica clara;
- Evita valores NULOS nas tuplas;
- Melhor desempenho;
- Facilidade de manutenção.

Também prevenimos **anomalias** de:
- Inserção;
- Atualização;
- Exclusão.

Para que a normalização ocorra, precisamos aplicar as **Formas Normais** juntamente com as regras de **Dependências Funcionais**.
- **FN (Formas Normais)** são técnicas usadas na padronização, são uma série de regras que visam eliminar a redundância e garantir a integridade dos dados.
- **DF (Dependência Funcional)** descreve a relação entre atributos em uma tabela, indicando como o valor de um atributo determina ou é determinado pelo valor de outro atributo.

## Dependência Funcional
Existem diferentes tipos de dependências funcionais que podem ocorrer em um banco de dados. Para a explicação funcionar claramente, usaremos X e Y como:
- `X` (Determinante) — ID
- `Y` (Dependente) — Campo

**1. Dependência Funcional Simples:** Ocorre quando o determinante determina completamente o valor do dependente.
- Dizemos que `Y` é funcionalmente dependente de `Y` se e somente se cada valor de `Y` estiver associado a `X`

**2. Dependência Funcional Parcial:** Nesse caso, o determinante determina apenas parcialmente o valor do dependente, ou seja, outros atributos também podem influenciar o valor do dependente além do determinante.
- Quando atributos não chave (`Y`) não dependem funcionalmente da chave primária (`X`) quando ela é composta.

**3. Dependência Funcional Total:** Ocorre quando um conjunto de atributos determina todos os outros atributos de uma tabela.
- Quando os atributos dependentes (`Y`) dependem do determinante (`X`)

**4. Dependência Funcional Transitiva:** Ocorre quando um atributo determina indiretamente outro atributo por meio de uma cadeia de dependências.
- Quando um atributo não chave (`Y`) depende de outro atributo não chave (`Y`).

**5. Dependência Funcional Multivalorada:** Ocorre quando um conjunto de atributos determina um conjunto de outros atributos, mas não há dependência funcional direta entre os atributos dentro desses conjuntos.
- Ocorre quando um atributo chave (`X`) multidetermina atributos não chave (`Y`) OU (`Y`) é multidependente de (`X`).

*Essas dependências são as que considero mais importantes no processo de modelagem e normalização. Existem outros tipos de dependências mais complexas, que não serão abordadas neste artigo. Dependendo da complexidade do seu modelo de normalização, essas serão úteis.*

## Formas Normais
As formas normais mais conhecidas e suas regras são as seguintes:

- **1FN:** Os dados são organizados em tabelas, com cada tabela contendo apenas valores atômicos e não repetidos. Isso significa que cada valor em uma coluna deve ser indivisível e não pode ser uma lista ou conjunto de valores.

- **2FN:** Além de atender aos critérios do 1FN, cada coluna não chave de uma tabela deve depender totalmente da chave primária da tabela. Isso significa que não deve haver dependências parciais, onde uma coluna não chave depende apenas de parte da chave primária.

- **3FN:** Além de atender aos critérios do 2FN, não deve haver dependências transitivas entre colunas não chave. Isso significa que se uma coluna depende de outra coluna que, por sua vez, depende de uma terceira coluna, então a primeira coluna deve ser movida para uma tabela separada.

- **4FN:** Além de atender aos critérios do 3FN, não deve haver dependências multivaloradas. Isso significa que não deve haver conjuntos de colunas que possam criar dependências indesejáveis entre si.

*Essas formas normais são as que considero mais importantes no processo de modelagem e padronização. Existem outros tipos de formas normais mais complexas, que não serão abordadas neste capítulo.*
