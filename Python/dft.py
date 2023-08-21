#!/bin/python3

from math import pi
from cmath import exp

"""
Computes the Discrete Fourier Transform of the input samples
"""
def DFT(samples: list) -> list:
    output = [0] * len(samples)
    for k in range(0, len(samples)):
        for n in range(0, len(samples)):
            output[k] += (samples[n] * exp(((-1j*2*pi)/len(samples))*k*n))

    return output


"""
Computes the Fast Fourier Transform of the input samples according to the 
Cooley-Tukey algorithm
"""
def FFT(samples: list):
    N = len(samples)

    if N == 1:
        return samples
    
    else:
        output = [0] * N

        even = FFT(samples[:N:2])
        odd = FFT(samples[1:N:2])

        for k in range(0, N//2):
            w = exp(-2j*pi * k/N)
            output[k] = even[k] + w * odd[k]
            output[k + N//2] = even[k] - w * odd[k]

        return output