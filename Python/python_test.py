#!/bin/python3

import numpy as np
import ctypes
import dft

import matplotlib.pyplot as plt

def test_python_dft():
    x = np.random.random(2048)
    x_cplx = x[0::2] + 1j * x[1::2]

    uut = dft.DFT(x_cplx)
    ref = np.fft.fft(x_cplx)
    
    comp = np.abs(uut - ref)
    if __name__ == "__main__":
        plt.plot(uut)
        plt.plot(ref)
        plt.show()
    for value in comp:
        if value > 10**-10:
            assert False

    assert True 

def test_python_fft():
    x = np.random.random(2048)
    x_cplx = x[0::2] + 1j * x[1::2]

    uut = dft.FFT(x_cplx)
    ref = np.fft.fft(x_cplx)
    
    comp = np.abs(uut - ref)
    if __name__ == "__main__":
        plt.plot(uut)
        plt.plot(ref)
        plt.show()
    for value in comp:
        if value > 10**-10:
            assert False

    assert True     

def test_c_dft():
    x = np.random.random(2048)
    x_cplx = x[0::2] + 1j * x[1::2]
    x_carr = (ctypes.c_float * len(x))(*x)
    uut = (ctypes.c_float * len(x))(*([0] * len(x)))
    
    lib = ctypes.CDLL("./fourier.so")
    lib.DFT(x_carr, uut, len(x))

    ref = np.fft.fft(x)

    comp = np.abs(uut - ref)
    if __name__ == "__main__":
        plt.plot(uut)
        plt.plot(ref)
        plt.show()
    for value in comp:
        if value > 10**-10:
            assert False

    assert True

def test_c_fft():
    x = np.random.random(2048)
    x_cplx = x[0::2] + 1j * x[1::2]
    x_carr = (ctypes.c_float * len(x))(*x)
    uut = (ctypes.c_float * len(x))(*([0] * len(x)))
    
    lib = ctypes.CDLL("./fourier.so")
    lib.FFT(x_carr, uut, len(x))

    ref = np.fft.fft(x)

    comp = np.abs(uut - ref)
    if __name__ == "__main__":
        plt.plot(uut)
        plt.plot(ref)
        plt.show()
    for value in comp:
        if value > 10**-10:
            assert False

    assert True  

if __name__ == "__main__":
    test_c_dft()
    test_c_fft()