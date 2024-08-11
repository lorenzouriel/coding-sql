# Bitmasking & Bitwise
**Bitmasking** e **Bitwise** são conceitos utilizados principalmente na programação para manipular e representar dados e objetos em nível de bits, permitindo operações eficientes.

**Bitmasking** refere-se ao processo de usar uma máscara de bits para manipular ou verificar o valor de bits específicos em um número binário. 

Isso é feito usando operadores **bitwise**, como AND (`&`), OR (`|`), XOR (`^`), NOT (`~`), entre outros. As máscaras de bits são usadas para definir quais bits de um número serão modificados, testados ou habilitados.

## Para que serve?

- **Permissões e Estados:** Pode ser usado para representar e manipular permissões ou estados em um sistema. Por exemplo, em um sistema de permissões, cada bit pode representar um nível de acesso.

- **Compactar Dados e Informações:** Em algumas situações, é possível compactar várias informações em um único campo usando bitmasking.

- **Otimização:** O uso de bitmasking pode ser mais eficiente em termos de tempo e espaço ao economizar campos na tabela.

## Breve resumo sobre bits, bytes e bases
O nível mais básico da representação de qualquer coisa em um computador é um bit.

Um bit é apenas um valor, podendo ser `0` ou `1`. Chamamos de Nibble quando temos quatro bits `0000` ou `1111`. Já um byte é composto por 08 bits: `0000 0000` ou `1111 1111`. 

Temos também a Word, que são 16 bits: `0000 0000 0000 0000` ou `1111 1111 1111 1111`.

**O que significa tudo isso?**

Se o Bit que possui o valor `1` está ligado e com o valor `0` está desligado. Então, em um Byte nós temos 08 opções de valores.

**Esses valores podem ser: campos, objetos, validações, ciclo de processos e muito mais.**

A melhor parte é que não tem um fim, você pode habilitar quantos bits forem necessários.

Para que possamos trabalhar com as operações **Bitwise**, nós fazemos a **conversão da Base 02 para a Base 10, ou melhor, de binário (Base 02) para decimal (Base 10).**

A melhor e mais prática maneira de trabalhar com isso é já **mapear os valores dos bits.**

Abaixo tem uma tabela **exemplo das conversões:**

- ![all_bits](/topics/imgs/09-bitmask/all_bits_on.png)


## Como Utilizar o Bitwise no SQL?
O primeiro passo é definir os quais são os valores que cada bit está relacionado.

Vou levar em consideração uma tabela de fato relacionado a um e-commerce.

**Ciclo de vida de um pedido:**
``` 
   Atributo                      Valor
   --------------------------------------      
   Pedido Realizado                 1     
   Pagamento em Processamento       2     
   Pagamento Identificado           4
   Entrega Rápida                   8
   Pedido Enviado para Entrega      16
   Pedido Entregues                 32
   Feedback do Cliente              64
   Pedido Cancelado                 128
```

Esse é um exemplo de como ficariam alguns exemplos usando **Bitwise** para adicionar os valores:
```
-- Pedido Realizado
 SELECT 1 | 1 -- (1)

-- Pagamento em Processamento 
 SELECT 1 | 2  -- (3)

-- Pagamento Identificado
 SELECT 1 | 2 | 4 -- (7)

-- O pedido já foi enviado?
 SELECT 1 | 2 | 16  -- (19)

-- Que tal uma entrega rápida?
 SELECT 1 | 2 | 8 | 16  -- (27)

-- O cliente quer cancelar a opção entrega rápida?
 SELECT 27 & ~8  -- (19)

 -- Antes de remover, a opção Entrega Rápida está habilitada?
 DECLARE @status INT = 27;

-- Verificar se o bit 8 está ligado (retorna 1 se estiver ligado, 0 se estiver desligado)
SELECT CASE WHEN (@status & 8) > 0 THEN 1 ELSE 0 END AS Bit8IsOn;
```

**O que estamos fazendo aqui?** Basicamente, desligando e ligando bits. 

**E de onde vem esses outros números?** Bom, essa tabela vai conseguir te explicar melhor.

- ![values_tables](/topics/imgs/09-bitmask/values_tables.png)
- https://terminaldeinformacao.com/2013/01/18/conversao-de-bases/

Se você reparar na opção Pagamento em processamento, nós ativamos os dois bits iniciais `0011`, com isso, ele retorna um `3`.

E isso é o que chamamos de **Bitmasking** com manipulação **Bitwise** no SQL.