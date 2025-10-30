#include <ap_int.h>

ap_uint<16> multiplicador8bits(ap_uint<8> a, ap_uint<8> b) {
    #pragma HLS INTERFACE ap_ctrl_none port=return
    #pragma HLS INTERFACE ap_none port=a
    #pragma HLS INTERFACE ap_none port=b

    return a * b;

}