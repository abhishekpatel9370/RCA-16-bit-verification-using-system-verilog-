`timescale 1ns / 1ps

module ripplecarryadder16bit(A, B, Cin, Cout, Sum);
    input [15:0] A, B;
    input Cin;
    output Cout;
    output [15:0] Sum;
    wire c1, c2, c3;

   
    ripplecarryadder4bit uut1 (A[3:0],   B[3:0],   Cin,  c1, Sum[3:0]);
    ripplecarryadder4bit uut2 (A[7:4],   B[7:4],   c1,   c2, Sum[7:4]);
    ripplecarryadder4bit uut3 (A[11:8],  B[11:8],  c2,   c3, Sum[11:8]);
    ripplecarryadder4bit uut4 (A[15:12], B[15:12], c3,  Cout, Sum[15:12]);
    

endmodule
