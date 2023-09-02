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
        even     : Complex_Vector(0 .. IQ'Length/2 - 1);
        odd      : Complex_Vector(0 .. IQ'Length/2 - 1);
        even_fft : Complex_Vector(0 .. IQ'Length/2 - 1);
        odd_fft  : Complex_Vector(0.. IQ'Length/2 - 1);
        even_idx : Standard.Integer := 0;
        odd_idx  : Standard.Integer := 0;
        W        : Ada.Numerics.Complex_Types.Complex;
        exponant : Ada.Numerics.Complex_Types.Complex;
        I_Float  : Standard.Float;
        IQ_Len   : Standard.Float;
    begin
        -- Set output to input if length is one
        if IQ'Length = 1 then
            output(0) := IQ(0);
            return output;
        end if;

        IQ_Len := Standard.Float(IQ'Length);

        for I in 0 .. IQ'Length - 1 loop
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

        for I in 0 .. IQ'Length/2 - 1 loop
            I_Float := Standard.Float(I);
            exponant := Complex'(0.0, Standard.Float'(
                ((-2.0 * Pi * I_Float)/IQ_Len)));
            W := e ** exponant;
            output(I) := even_fft(I) + W * odd_fft(I);
            output(I + IQ'Length/2) := even_fft(I) - W * odd_fft(I);
        end loop;

        return output;
    end FFT;

    function FFT_CONC ( IQ : Complex_Vector) return Complex_Vector is
    
        task FFT_TASK is
            entry Go ( IQ : Complex_Vector);
            entry Get ( Result : out Complex_Vector);
        end FFT_TASK;

        task body FFT_TASK is
            Int_IQ     : Complex_Vector(0 .. IQ'Length/2 - 1);
            Int_Result : Complex_Vector(0 .. IQ'length/2 - 1);
        begin
            
            
            accept Go ( IQ : Complex_Vector) do
                    Int_IQ := IQ;
            end Go;
            
            Int_Result := FFT(Int_IQ);

            accept Get ( Result : out Complex_Vector) do
                Result := Int_Result;
            end Get;
        end FFT_TASK;

        output   : Complex_Vector(IQ'Range);
        even     : Complex_Vector(0 .. IQ'Length/2 - 1);
        odd      : Complex_Vector(0 .. IQ'Length/2 - 1);
        even_fft : Complex_Vector(0 .. IQ'Length/2 - 1);
        odd_fft  : Complex_Vector(0.. IQ'Length/2 - 1);
        even_idx : Standard.Integer := 0;
        odd_idx  : Standard.Integer := 0;
        W        : Ada.Numerics.Complex_Types.Complex;
        exponant : Ada.Numerics.Complex_Types.Complex;
        I_Float  : Standard.Float;
        IQ_Len   : Standard.Float;
    begin
        -- Set output to input if length is one
        if IQ'Length = 1 then
            output(0) := IQ(0);
            return output;
        end if;

        IQ_Len := Standard.Float(IQ'Length);

        for I in 0 .. IQ'Length - 1 loop
            if I mod 2 = 0 then
                even(even_idx) := IQ(I);
                even_idx := even_idx + 1;
            else
                odd(odd_idx) := IQ(I);
                odd_idx := odd_idx + 1;
            end if;
        end loop;

        FFT_TASK.Go(even);
        odd_fft  := FFT(odd);
        FFT_TASK.Get(even_fft);

        for I in 0 .. IQ'Length/2 - 1 loop
            I_Float := Standard.Float(I);
            exponant := Complex'(0.0, Standard.Float'(
                ((-2.0 * Pi * I_Float)/IQ_Len)));
            W := e ** exponant;
            output(I) := even_fft(I) + W * odd_fft(I);
            output(I + IQ'Length/2) := even_fft(I) - W * odd_fft(I);
        end loop;
        return output;

    end FFT_CONC;
end DSP_Custom;