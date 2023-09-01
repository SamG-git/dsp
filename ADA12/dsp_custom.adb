with Ada.Numerics.Complex_Types;
use Ada.Numerics.Complex_Types;
with Ada.Numerics.Complex_Elementary_Functions;
use Ada.Numerics.Complex_Elementary_Functions;
with Ada.Numerics; use Ada.Numerics;

with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Text_IO.Complex_IO;


package body DSP_Custom is

    function FFT ( IQ : Complex_Vector) return Complex_Vector is
        output   : Complex_Vector(IQ'Range);
        even     : Complex_Vector(1 .. IQ'Length/2);
        odd      : Complex_Vector(1 .. IQ'Length/2);
        even_fft : Complex_Vector(1 .. IQ'Length/2);
        odd_fft  : Complex_Vector(1 .. IQ'Length/2);
        even_idx : Standard.Integer := 1;
        odd_idx  : Standard.Integer := 1;
        W        : Ada.Numerics.Complex_Types.Complex;
        exponant : Ada.Numerics.Complex_Types.Complex;
        I_Float  : Standard.Float;
        IQ_Len   : Standard.Float;
    begin
        -- Set output to input if length is one
        if IQ'Length = 1 then
            output(1) := IQ(1);
            return output;
        end if;

        IQ_Len := Standard.Float(IQ'Length);

        for I in 1 .. IQ'Length loop
            if I mod 2 = 0 then
                even(even_idx) := IQ(I);
                even_idx := even_idx + 1;
            else
                odd(odd_idx) := IQ(I);
                odd_idx := odd_idx + 1;
            end if;
        end loop;

        even_fft := FFT(even);
        odd_fft  := FFT(odd);

        for I in 1 .. IQ'Length/2 loop
            I_Float := Standard.Float(I);
            exponant := Complex'(0.0, Standard.Float'(
                ((-2.0 * Pi * I_Float)/IQ_Len)));
            W := e ** exponant;
            output(I) := even(I) + W * odd(I);
            output(I + IQ'Length/2) := even(I) - W * odd(I);
        end loop;

        return output;
    end FFT;
end DSP_Custom;