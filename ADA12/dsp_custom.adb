with Ada.Numerics.Complex_Types;
use Ada.Numerics.Complex_Types;
with Ada.Numerics.Complex_Elementary_Functions;
use Ada.Numerics.Complex_Elementary_Functions;
with Ada.Numerics; use Ada.Numerics;

package body DSP_Custom is
    function DFT ( IQ: Complex_Vector) return Complex_Vector is
        output : Complex_Vector(IQ'Range);
        tab : Ada.Numerics.Complex_Types.Complex;
        exponant : Ada.Numerics.Complex_Types.Complex;
        K_Float : Standard.Float;
        N_Float : Standard.Float;
        IQ_Len  : Standard.Float;
    begin
        IQ_Len := Standard.Float(IQ'Length);
        for K in IQ'Range loop
            tab := (0.0, 0.0);
            for N in IQ'Range loop
                K_Float := Standard.Float(K);
                N_Float := Standard.Float(N);
                exponant := Complex'(0.0, Standard.Float'(
                    ((-2.0 * Pi)/IQ_Len) * K_Float * N_Float));
                tab := tab + e ** exponant;
            end loop;
            output(K) := tab;
        end loop;
        return output;
    end DFT;
end DSP_Custom;