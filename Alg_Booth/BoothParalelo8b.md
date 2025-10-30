# BoothParalelo8b

Este documento descreve em detalhe a arquitetura VHDL do multiplicador paralelo de 8 bits baseado no algoritmo de Booth modificado, implementado no arquivo `BoothParalelo8b.vhd`.

## Visão geral
- **Entradas:** `A`, `B` (`std_logic_vector(7 downto 0)`)
- **Saída:** `S` (`std_logic_vector(15 downto 0)`)
- **Objetivo:** reduzir o número de produtos parciais e somas necessárias por meio do algoritmo de Booth aplicado em blocos de dois bits.

## Organização interna
A arquitetura `BoothP` segue três fases principais:

1. **Geração de sinais de controle**
   - Constrói sinais `passamdX` e `shiftmdX` para cada par de bits do multiplicando `A`.
   - Esses sinais determinam se o bloco Booth aplica transmissão direta do multiplicando (`passamd`) ou uma combinação com deslocamento (`shiftmd`).

2. **Geração de produtos parciais (`pp`)**
   - Usa combinações lógicas entre `A`, `B` e os controles `passamd`/`shiftmd` para produzir os vetores `pp(0)` a `pp(35)`.
   - O primeiro bloco utiliza o bit menos significativo de `A` com constante `zero`, definindo a fronteira para as etapas seguintes.
   - Os blocos restantes percorrem pares de bits de `A`: `(A2,A1)`, `(A4,A3)` e `(A6,A5)`, replicando o padrão de geração adaptado para Booth.

3. **Redução em árvore de somas**
   - Os vetores `soma` e `c` armazenam resultados e carries intermediários.
   - Primeira redução: combina o primeiro e o segundo conjuntos de produtos (`soma(0)` a `soma(8)`).
   - Segunda redução: adiciona o terceiro conjunto (`soma(9)` a `soma(17)`).
   - Terceira redução: agrega o quarto conjunto (`soma(18)` a `soma(26)`).
   - Constantes `c(8)`, `c(17)` e `c(26)` forçam limites de propagação de carry.

## Mapeamento da saída
- `S(0)` e `S(1)` são conectados diretamente aos bits menos significativos do primeiro produto parcial (`pp(0)` e `pp(1)`).
- `S(2)` a `S(14)` derivam das posições de `soma` resultantes da redução.
- `S(15)` repete `soma(26)`, garantindo coerência do bit de sinal quando há extensão para complemento de dois.

## Pontos de atenção para síntese e simulação
- Confirme o tamanho de `pp` e `soma` conforme a ferramenta de síntese, evitando truncamentos.
- O algoritmo assume representação em complemento de dois; forneça vetores de entrada coerentes.
- Recomendado simular casos com operandos negativos, zero e extremos (`0x80`, `0x7F`) para validar a propagação do bit de sinal.
