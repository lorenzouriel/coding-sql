# Propriedades ACID

Já ouviu falar das propriedades ACID? É hora!

As propriedades **ACID** são um conjunto de características que garantem a confiabilidade e consistência dos dados em sistemas de gerenciamento de banco de dados relacionais. O termo **ACID** é um acrônimo formado pelas primeiras letras das quatro propriedades que o compõem: 
- Atomicidade
- Consistência
- Isolamento
- Durabilidade

As propriedades **ACID** surgiram quando os sistemas de gerenciamento de banco de dados relacionais começaram a se tornar populares, sendo principalmente usados para aplicações financeiras e outras críticas em dados.

Como resultado, foi necessário estabelecer um **conjunto de padrões que garantissem a integridade dos dados**.

As propriedades **ACID** foram desenvolvidas para atender a essa necessidade, rapidamente se tornando um padrão para sistemas de banco de dados relacionais. Elas foram incorporadas a muitos sistemas de gerenciamento de banco de dados relacionais, incluindo Oracle, MySQL e PostgreSQL, para garantir a confiabilidade e consistência dos dados em todas as aplicações.

As propriedades **ACID** são as seguintes:

1. **Atomicidade:** Tudo acontece ou nada é considerado... Isso significa que todas as operações devem ser executadas com sucesso ou, se uma operação falhar, todas as operações devem ser revertidas para o estado anterior. Isso garante que os dados sempre permaneçam consistentes.

2. **Consistência:** Se estava ok antes, então também tem que estar agora... Esta propriedade garante que a transição de um estado para outro sempre mantenha a integridade dos dados. Isso significa que se uma transação violar as regras de integridade definidas no banco de dados, a transação será revertida para seu estado anterior.

3. **Isolamento:** Se as coisas acontecem de maneira paralela, elas precisam estar isoladas... Esta propriedade garante que as transações sejam executadas de forma isolada uma da outra, para que a execução de uma transação não afete o resultado de outra transação que esteja sendo executada simultaneamente. Isso garante que os dados permaneçam consistentes mesmo quando várias transações estão sendo executadas simultaneamente.

4. **Durabilidade:** Dura o tempo que for necessário... Esta propriedade garante que, após uma transação ser concluída com sucesso, os dados modificados permaneçam persistentes no banco de dados, mesmo em caso de falha do sistema. Isso significa que uma vez feitas as alterações, elas são permanentes e não serão perdidas devido a falhas do sistema.

Por que eu escrevi **ACID** tantas vezes?

Para você não esquecer.

**Agora repita comigo:** 
- **Atomicidade:** Tudo acontece ou nada é considerado
- **Consistência:** Se estava ok antes, depois também precisa estar ok
- **Isolamento:** Se as coisas acontecem de maneira paralela, elas precisam estar isoladas
- **Durabilidade:** Dura o tempo que for necessário

Entender isso levará sua compreensão de bancos de dados relacionais e transações para outro nível!