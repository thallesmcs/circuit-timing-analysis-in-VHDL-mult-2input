# Circuito Timing Multiplicadores

Este repositório contém duas implementações VHDL de multiplicadores com arquiteturas distintas: uma versão baseada no algoritmo de Booth em paralelo e uma realização utilizando um arranjo de somadores do tipo ripple-carry (RCA) com decomposição em blocos radix-4. A seguir descrevemos em detalhes cada arquivo, suas entidades, sinais internos e o fluxo de operação.

## BoothParalelo8b.vhd

### Objetivo geral
Implementa um multiplicador paralelo de 8 bits baseado no algoritmo de Booth modificado. Recebe dois operandos de 8 bits (`A` e `B`) e gera um produto de 16 bits (`S`). A arquitetura `BoothP` cria produtos parciais de forma otimizada, reduzindo a quantidade de operações de soma necessárias.

### Estrutura principal
- **Entradas:** `A`, `B` (`std_logic_vector(7 downto 0)`)
- **Saída:** `S` (`std_logic_vector(15 downto 0)`)
- **Sinais auxiliares:**
  - `passamdX` e `shiftmdX`: controlam a passagem ou deslocamento dos bits do multiplicando conforme as regras do Booth.
  - `aux` e `caux`: armazenam resultados intermediários do primeiro produto parcial e seus carries.
  - `pp`: vetor que reúne todos os produtos parciais gerados.
  - `soma` e `c`: acumulam as somas e propagam os carries na etapa de redução dos produtos parciais.

### Funcionamento
1. **Inicialização:** define constantes `zero` e `um` para simplificar expressões booleanas.
2. **Primeiro produto parcial:** manipula os dois LSBs de `A` para determinar os sinais de Booth e calcula a primeira linha de `pp`.
3. **Demais produtos parciais:** repete o padrão para os pares de bits (A2,A1), (A4,A3) e (A6,A5), produzindo as entradas `pp(9)` a `pp(35)`.
4. **Redução em árvore de somas:** combina os produtos parciais em três etapas:
   - Soma do primeiro com o segundo conjunto (`soma(0)` a `soma(8)`);
   - Inclusão do terceiro conjunto (`soma(9)` a `soma(17)`);
   - Inclusão do quarto conjunto (`soma(18)` a `soma(26)`).
5. **Mapeamento da saída:** atribui os bits de `S` combinando diretamente produtos parciais ou resultados das somas reduzidas.

### Pontos de atenção
- O algoritmo aplica regras do Booth a blocos de 2 bits, reduzindo transições e número de somadores em comparação com multiplicação tradicional.
- Os bits mais significativos utilizam redundância (`S(14)` e `S(15)` recebem o mesmo valor) devido à lógica de sinal do Booth modificado.

## RCA_radix4_8b.vhd

### Objetivo geral
Realiza a multiplicação de dois números de 8 bits via decomposição radix-4 e uma rede de somadores ripple-carry. A arquitetura é modular, composta por diversos componentes reutilizáveis (half adders, full adders e blocos de geração de produtos parciais) conectados em uma árvore de redução.

### Organização do arquivo
O código declara uma série de entidades auxiliares antes da entidade principal `RCA_radix4_8b`. Cada bloco tem uma função específica dentro da hierarquia:

1. **Módulos básicos:**
   - `RCAmulttipo1xm28b`, `RCAmulttipo2xam28b`, `RCAmulttipo2xm28b`, `RCAmulttipo3xm28b`: geradores de produtos parciais para pares de bits (2×2). Cada variação implementa lógica combinacional diferente para otimizar sinais de carry e propagação.
   - `RCAhalfadderm28b`, `RCAfulladderm28b`, `RCAfulladder_nppm28b`: somadores básicos utilizados na redução.

2. **Pacotes de componentes:**
   - `my_componentsm28bRCA`, `my_components1m28bRCA` e `my_components2m28bRCA`: disponibilizam as declarações `COMPONENT` necessárias para instanciar os módulos nos níveis superiores.

3. **Blocos intermediários de 2 bits:**
   - `RCAhalfadder_2Bitsm28b` e `RCAfulladder_2Bitsm28b`: combinam os somadores básicos para lidar com blocos de 2 bits e carry associado.
   - `RCAbitsadder_2Bitsm28b` e `RCAfulladder_npp_2Bitsm28b`: variantes especializadas para adicionar pares de bits sem propagar carry completo ou com precomputação específica.

4. **Operandos radix-4:**
   - `RCAoperando1m28b` e `RCAoperando2m28b`: organizam a geração de produtos parciais para blocos de 2 bits dos operandos `A` e `B`. Cada estágio multiplica uma fatia de `A` por todo `B`, produzindo vetores intermediários `W0` a `W3`.

5. **Entidade principal `RCA_radix4_8b`:**
   - **Entradas:** `A`, `B` (`std_logic_vector(7 downto 0)`)
   - **Saída:** `S` (`std_logic_vector(15 downto 0)`)
   - **Sinais internos:**
     - `W0` a `W3`: vetores de 10 bits contendo produtos parciais de cada dupla de bits de `A` com `B`.
     - `F0` a `F7`: vetores de 16 bits usados nas camadas da árvore de somadores.
     - `COUT0` a `COUT8`: vetores de 8 bits que acumulam os carries em cada nível.

### Fluxo de operação
1. **Geração de produtos parciais:** quatro instâncias de `RCAoperandoXm28b` recebem pares de bits de `A` (`A(1:0)`, `A(3:2)`, `A(5:4)`, `A(7:6)`) e o vetor completo `B`. Cada bloco retorna um vetor `Wn` com os produtos parciais já pré-somados internamente e os dois bits menos significativos do produto parcial direto.
2. **Redução em árvore (RCA Tree):** sequência de estágios `estagioXXRCA` somam os vetores resultantes.
   - A primeira camada combina `W0` e `W1`, produzindo `F0`.
   - A segunda camada incorpora `W2`, produzindo `F1`.
   - A terceira camada adiciona `W3`, gerando `F2`.
   - Camadas adicionais (`F3` a `F5`) continuam a reduzir os dados até mapear diretamente para os bits de saída `S(0)` a `S(31)`, apesar do vetor de saída final declarado como 16 bits; os índices superiores (`S(31:16)`) representam etapas intermediárias não conectadas de volta à entidade externa.
3. **Propagação de carry:** cada estágio usa `RCAhalfadder_2Bitsm28b` e `RCAfulladder_2Bitsm28b` para administrar somas de 2 bits com propagação de carry, reduzindo o tempo crítico.

### Observações importantes
- O arquivo contém uma arquitetura altamente modular, apropriada para estudo de multiplicadores radix-4 e análise de tempo de propagação.
- Alguns vetores (`W0`, `W1`, etc.) são indexados até posições superiores (por exemplo, `W0(15)`) mesmo que os sinais sejam declarados com menos bits. Isso sugere que o código pode estar incompleto ou derivado de uma versão expandida; revise larguras para evitar inconsistências na síntese.
- O design considera saídas expandidas (`S(31 downto 0)` em alguns estágios) para acomodar carries excedentes, embora o porto final `S` seja de 16 bits.

## Recomendações de uso
- Verifique e ajuste larguras de vetores antes da síntese para garantir compatibilidade com a ferramenta alvo.
- Para simulação, forneça bancos de testes que cubram casos com sinais positivos e negativos (no caso do Booth) e verifique as transições de carry no arranjo RCA.
- Documente as convenções de sinal (sign magnitude, complemento de dois) para os operandos, especialmente no multiplicador Booth, que pressupõe tratamento de sinal pela lógica que antecede `S(15)`.

<!-- ## Licença
Defina aqui a licença do projeto, caso aplicável. -->


# Quartus Prime 24.1std

## Fmax

**Analise de Fmax em Multiplicadores de 8 Bits 2 Entradas**

| Bits | Algoritmo de Booth (MHz) | Algoritmo com RCA (MHz) | HLS Puro (MHz) |
|:----:|:------------------------:|:-----------------------:|:--------------:|
|  8   |          131,94          |          237,02         |     343,29     |

## Recursos

**Analise de Recursos em Multiplicadores de 8 Bits 2 Entradas**

| Bits | Algoritmo de Booth (Total LE) | Algoritmo com RCA (Total LE) | HLS Puro (Total LE) |
|:----:|:-----------------------------:|:----------------------------:|:-------------------:|
|  8   |              114              |              66              |         0           |

Note: HLS Puro utilizou "Embedded Multiplier 9-bit elements: 1/132".

## Gráficos e Tabelas 

Os gráficos e tabelas complementares gerados a partir das análises estão disponíveis na pasta [`doc/img`](doc/img).