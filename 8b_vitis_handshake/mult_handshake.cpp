#include "ap_int.h"

/*
 * Função Top-Level para síntese no Vitis HLS
 * Multiplica duas entradas de 8 bits (A, B) e armazena
 * o resultado em uma saída de 16 bits (P).
 */
void multiplier_8bit(
    ap_uint<8>  A,       // Entrada de 8 bits A
    ap_uint<8>  B,       // Entrada de 8 bits B
    ap_uint<16> &P       // Saída de 16 bits (Produto)
) {
    // --- Pragmas de Interface ---
    // Define a interface de controle do bloco (start, done, ready)
    #pragma HLS INTERFACE ap_ctrl_hs port=return

    // Define as portas de dados de entrada
    #pragma HLS INTERFACE ap_none port=A
    #pragma HLS INTERFACE ap_none port=B

    // Define a porta de dados de saída
    #pragma HLS INTERFACE ap_none port=P

    // --- Lógica da Função ---
    // A operação de multiplicação. O Vitis HLS irá
    // inferir o multiplicador de hardware (provavelmente usando um DSP slice
    // ou lógica LUT, dependendo da sua placa e diretivas).
    P = A * B;
}