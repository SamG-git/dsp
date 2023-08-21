#include <tgmath.h>
#include <complex.h>
#include <string.h>
#include <stdlib.h>

void DFT(float complex *input, float* output, size_t size){
    for(size_t k = 0; k < size; k++){
        float element = 0.0;
        for(size_t n = 0; n < size; n++){
            element += (input[n] * cexp(((-I*2*M_PI)/size))* k * n);
        }
        output[k] = element;
    }
}

void FFT(float complex *input, float* output, size_t size){
    if(size == 1){
        *output = *input;
    } else {
        float even[size/2];
        float odd[size/2];
        complex float input_even[size/2];
        complex float input_odd[size/2];

        for(size_t i = 0; i < size; i+=2){
            input_even[i/2] = input[i];
            input_odd[i/2] = input[i+1];
        }

        FFT(input_even, even, size/2);
        FFT(input_odd, odd, size/2);

        for(size_t k = 0; k < size / 2; k++){
            float w = cexp(-2 * M_PI * I * k/size);
            output[k] = even[k] + w * odd[k];
            output[k + size/2] = even[k] - w * odd[k];
        }
    }
}

void DFT_python(float *input, float *output, size_t size);
void FFT_python(float *input, float *output, size_t size);
