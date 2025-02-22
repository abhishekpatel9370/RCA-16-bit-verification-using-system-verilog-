`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2025 01:36:56 PM
// Design Name: 
// Module Name: tb_rca16
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_rca_16;
    // Declare inputs and outputs
    logic [15:0] A, B;  
    logic        cin;   
    logic [15:0] s;    
    logic        co;   
 parameter WIDTH=16;
    
    logic [16:0] expected_sum;

    
    ripplecarryadder16bit dut (
    .A(A),
    .B(B),
    .Cin(cin),
    .Sum(s[WIDTH-1:0]),
    .Cout(co)
  );

    task run_test(input logic [15:0] a, input logic [15:0] b, input logic c);
        begin
            A   = a;
            B   = b;
            cin = c;
            #10; 
            
            expected_sum = A + B + cin; 

            // Assertions
            assert (s == expected_sum[15:0]) else
                $error("Mismatch: A=%b, B=%b, Cin=%b, Expected Sum=%b, Got Sum=%b", A, B, cin, expected_sum[15:0], s);

            assert (co == expected_sum[16]) else
                $error("Mismatch: A=%b, B=%b, Cin=%b, Expected Cout=%b, Got Cout=%b", A, B, cin, expected_sum[16], co);
        end
    endtask

    task constrained_random_test();
        begin
            repeat (10) begin 
                A   = $rand; 
                B   = $rand;
                cin = $rand % 2; 
                #10;
                
                expected_sum = A + B + cin;

                // Assertions
                assert (s == expected_sum[15:0]) else
                    $error("Random Test Mismatch: A=%b, B=%b, Cin=%b, Expected Sum=%b, Got Sum=%b", A, B, cin, expected_sum[15:0], s);

                assert (co == expected_sum[16]) else
                    $error("Random Test Mismatch: A=%b, B=%b, Cin=%b, Expected Cout=%b, Got Cout=%b", A, B, cin, expected_sum[16], co);
            end
        end
    endtask

    
    task directed_test_cases();
        begin
            
            run_test(16'b0000000000000000, 16'b0000000000000000, 0); // 0 + 0 + 0 = 0

            
            run_test(16'b1111111111111111, 16'b0000000000000001, 0); // Max + 1 Overflow
            run_test(16'b1111111111111111, 16'b1111111111111111, 1); // Max + Max + 1  Max Overflow

            
            run_test(16'b0000000000000001, 16'b0000000000000010, 1); // 1 + 2 + 1 = 4
            run_test(16'b1010101010101010, 16'b0101010101010101, 0); 
        end
    endtask

    
    initial begin
        $display("Starting Directed Test Cases...");
        directed_test_cases();
        $display("Directed Tests Completed.");

        $display("Starting Constrained Random Testing...");
        constrained_random_test();
        $display("Random Tests Completed.");

        $display("All Tests Finished.");
        $stop;
    end
endmodule