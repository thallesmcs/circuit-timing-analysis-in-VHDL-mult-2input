# RCA_radix4_8b

Descrição detalhada do multiplicador radix-4 baseado em somadores ripple-carry (`RCA_radix4_8b.vhd`). O design utiliza geração modular de produtos parciais e uma árvore de somadores organizada em blocos de 2 bits.

## Entradas e saídas principais
- **Entradas:** `A`, `B` (`std_logic_vector(7 downto 0)`)
- **Saída:** `S` (`std_logic_vector(15 downto 0)`)
- **Objetivo:** explorar decomposição radix-4 do multiplicando para gerar 4 blocos de produtos parciais e combiná-los em uma rede RCA de alta regularidade.

## Componentes básicos
O arquivo declara vários blocos elementares reutilizáveis:
- `RCAhalfadderm28b`, `RCAfulladderm28b`: somadores de 1 bit com e sem carry-in.
- `RCAfulladder_nppm28b`: variante sem carry-out, usada em etapas intermediárias.
- `RCAmulttipo1xm28b`, `RCAmulttipo2xam28b`, `RCAmulttipo2xm28b`, `RCAmulttipo3xm28b`: geradores de produtos parciais 2×2 com diferentes otimizações de porta.
- Pacotes `my_componentsm28bRCA`, `my_components1m28bRCA` e `my_components2m28bRCA` expõem esses componentes para instanciá-los nas camadas superiores.

## Blocos de 2 bits
- `RCAhalfadder_2Bitsm28b` e `RCAfulladder_2Bitsm28b`: encapsulam a soma de dois bits com gerenciamento explícito de carry.
- `RCAbitsadder_2Bitsm28b`: soma um vetor de 2 bits com um carry de entrada, útil na borda superior da rede.
- `RCAfulladder_npp_2Bitsm28b`: somador de 2 bits sem carry de saída, empregado em compressões intermediárias.

## Geração de produtos parciais
Dois blocos especializados (`RCAoperando1m28b` e `RCAoperando2m28b`) recebem pares de bits de `A` e o vetor completo `B`, retornando vetores `Wn` de 10 bits que já incorporam pré-somas internas. Cada bloco produz simultaneamente dois bits de saída imediata (por exemplo, `S(1 downto 0)` na primeira instância) e um conjunto de sinais usados na árvore RCA.

## Árvore de somadores (RCA Tree)
- Estágios `estagio10RCA` a `estagio86RCA` combinam gradualmente os vetores `W0`, `W1`, `W2`, `W3` e os resultados intermediários `F0` a `F5`.
- Cada estágio opera sobre pares de bits com `RCAhalfadder_2Bitsm28b` ou `RCAfulladder_2Bitsm28b`, propagando carries por meio dos vetores `COUT0` a `COUT6`.
- A estrutura em cascata mantém a regularidade e facilita o mapeamento para hardware pipelineado, embora o tempo crítico dependa do comprimento da cadeia RCA.

## Considerações práticas
- Vários vetores internos são indexados além dos limites declarados (por exemplo, `W0(15)` quando `W0` é `Std_Logic_Vector(9 downto 0)`). Ajuste as larguras ou revise trechos derivados para evitar warnings ou erros de síntese.
- A saída `S` oficialmente tem 16 bits, mas a rede produz valores adicionais (`S(31 downto 16)`) em estágios internos; confirme quais bits precisam estar conectados externamente.
- Execute simulação extensiva para validar a coerência dos carries e a precisão dos blocos `RCAmulttipoX`, garantindo cobertura para sinais positivos e negativos.
