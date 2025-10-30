# Comparação: BoothParalelo8b vs. RCA_radix4_8b

## Abordagem algorítmica
- **BoothParalelo8b:** aplica o algoritmo de Booth modificado em blocos de dois bits, otimizando multiplicações por reduzir transições no multiplicando e reutilizar complementos.
- **RCA_radix4_8b:** divide o multiplicando em quatro blocos radix-4 e utiliza multiplicadores 2×2 combinados com uma árvore de somadores ripple-carry.

## Estrutura de hardware
- **Booth:** concentra lógica combinacional na geração dos sinais `passamd`/`shiftmd` e na compressão dos produtos parciais em três níveis de soma. Mantém vetor `pp` único com 36 entradas.
- **RCA:** fortemente modular com muitos componentes básicos (half/full adders) e pacotes de componentes. A árvore RCA possui dezenas de estágios nomeados (`estagio10RCA`, etc.) que operam sobre vetores `Wn` e `Fn`.

## Propagação de carry
- **Booth:** compressão em camadas minimiza a profundidade da cadeia de carry, pois cada etapa resolve um conjunto limitado de bits.
- **RCA:** utiliza ripple-carry em blocos de 2 bits; apesar do paralelismo entre pares, a cadeia global é mais longa e pode resultar em maior tempo crítico.

## Suporte a sinais
- **Booth:** projetado para complemento de dois; o bit de sinal é replicado em `S(15)` garantindo sinal correto para entradas negativas.
- **RCA:** requer tratamento externo para sinais; a implementação atual assume operandos sem sinal ou depende de extensão manual.

## Complexidade e modularidade
- **Booth:** código relativamente compacto, com foco em lógica combinacional dentro de uma única arquitetura.
- **RCA:** arquivo extenso com múltiplas entidades, pacotes e instâncias; facilita reuso e experimentação com diferentes blocos, porém aumenta a complexidade de manutenção.

## Pontos de atenção
- **Booth:** revisar `pp` e `soma` para evitar saturações e confirmar que `S(14)`/`S(15)` atendem à especificação.
- **RCA:** ajustar larguras de vetores (`Wn`, `Fn`, `COUTn`) a fim de eliminar índices fora do intervalo e garantir que apenas `S(15 downto 0)` sejam exportados.

## Quando usar cada um
- **BoothParalelo8b:** preferível quando o foco é desempenho com suporte a números com sinal e menor quantidade de blocos repetidos.
- **RCA_radix4_8b:** indicado para ambientes didáticos ou prototipagem de arquiteturas modulares, onde a clareza da composição e a possibilidade de trocar blocos são prioritárias.
