#include "fourier.h"

void DFT_python(float *input, float*output, size_t size){
    // De-interleave input
    complex float *input_complex = (float complex*)(input);

    DFT(input_complex, output, size); 
}

void FFT_python(float *input, float*output, size_t size){
    // De-interleave input
    complex float *input_complex = (float complex*)(input);

    FFT(input_complex, output, size); 
}