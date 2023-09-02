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

with Ada.Real_time; use Ada.Real_time;

procedure MAIN is

   package C_IO is new
     Ada.Text_IO.Complex_IO (Complex_Types);
   use C_IO;

    G : Generator;
    IQ : DSP_Custom.Complex_Vector(0 .. 32768 - 1);
    IQ_fft : DSP_Custom.Complex_Vector(0 .. 32768 - 1);
    IQ_fft_conc : DSP_Custom.Complex_Vector(0 .. 32768 - 1);

    Start_Time, Stop_Time : Time;
    Elapsed_Time          : Time_Span;
begin
    Reset(G);
    
    Start_Time := Clock;
    for REP in 0 .. 100 loop
        for N in IQ'Range loop
            IQ(N) := (Random(G), Random(G));
        end loop;
        
        IQ_fft := DSP_Custom.FFT(IQ);
    end loop;
    Stop_Time := Clock;
    Elapsed_Time := Stop_Time - Start_Time;

    Put_Line("Standard FFT Execution Time " & Duration'Image(
        To_Duration (Elapsed_Time)
    ) & "s");

    Start_Time := Clock;
    for REP in 0 .. 100 loop
        for N in IQ'Range loop
            IQ(N) := (Random(G), Random(G));
        end loop;
        
        IQ_fft_conc := DSP_Custom.FFT_CONC(IQ);
    end loop;
    Stop_Time := Clock;
    Elapsed_Time := Stop_Time - Start_Time;

    Put_Line("Concurrent FFT Execution Time " & Duration'Image(
        To_Duration (Elapsed_Time)
    ) & "s");

end MAIN;