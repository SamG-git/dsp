with Ada.Numerics.Complex_Types;
with Ada.Numerics.Complex_Elementary_Functions;

package DSP_Custom is
    type Complex_Vector is array(Integer range <>) of
        Ada.Numerics.Complex_Types.Complex;
    function DFT (IQ : Complex_Vector) return Complex_Vector;
    function FFT (IQ : Complex_Vector) return Complex_Vector;
end DSP_Custom;