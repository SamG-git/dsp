with DSP_Custom;
with Ada.Text_IO;  use Ada.Text_IO;
with Ada.Numerics; use Ada.Numerics;

with Ada.Numerics.Complex_Types;
use  Ada.Numerics.Complex_Types;

with Ada.Numerics.Complex_Elementary_Functions;
use  Ada.Numerics.Complex_Elementary_Functions;

with Ada.Numerics.Float_Random;
use  Ada.Numerics.Float_Random;

with Ada.Text_IO.Complex_IO;
procedure MAIN is

   package C_IO is new
     Ada.Text_IO.Complex_IO (Complex_Types);
   use C_IO;

    G : Generator;
    IQ : DSP_Custom.Complex_Vector(0 .. 3);
    IQ_fft : DSP_Custom.Complex_Vector(0 .. 3);
    IQ_fft_conc : DSP_Custom.Complex_Vector(0 .. 3);
begin
    Reset(G);
    
    for N in IQ'Range loop
        IQ(N) := (Random(G), Random(G));
        Put (IQ(N));
    end loop;
    New_Line;
    
    IQ_fft := DSP_Custom.FFT(IQ);
    IQ_fft_conc := DSP_Custom.FFT_CONC(IQ);

    for N in IQ'Range loop
        IQ(N) := (Random(G), Random(G));
        Put (IQ_fft(N));
    end loop;
    New_Line;

    for N in IQ'Range loop
        IQ(N) := (Random(G), Random(G));
        Put (IQ_fft_conc(N));
    end loop;
    New_Line;
end MAIN;