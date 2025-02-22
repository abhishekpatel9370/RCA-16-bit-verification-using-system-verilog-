This  project is a verification of a 16-bit Ripple Carry Adder (RCA) with SystemVerilog. The testbench (tb_rca_16.sv) is an implementation of several directed and random test cases for verifying the functional correctness of the adder.

Features
Parameterized 16-bit RCA Verification
Task-Based Testing Approach
Assertions for Functional Correctness
Directed and Constrained Random Testing
Edge Case Validation (Overflow, Zero Addition, Handling of Carry-in)
Testbench Description
1. Instantiation of RCA
The testbench instantiates the module of the 16-bit ripple carry adder and assigns the input and output ports:

systemverilog
Copy
Edit
ripplecarryadder16bit dut
.A(A),
.B(B),
.Cin(cin),
.Sum(s[WIDTH-1:0]),
.Cout(co)
);
2. Test Methodology
The testbench uses task-based testing to improve modularity and maintainability.

a) Directed Test Cases
The run_test task executes predefined cases with known expected results:

systemverilog
Copy
Edit
task run_test(input logic [15:0] a, input logic [15:0] b, input logic c);
begin
A = a;
B = b;
cin = c;
#10;
expected_sum = A + B + cin;

// Assertions
assert (s == expected_sum[15:0]) else
$error("Mismatch: Expected Sum=%b, Got Sum=%b", expected_sum[15:0], s);

assert (co == expected_sum[16]) else
$error("Mismatch: Expected Cout=%b, Got Cout=%b", expected_sum[16], co);
end
endtask
Test Cases Covered:
Addition of zero operands
Overflow conditions
Addition of maximum values
Carry-in effects
Randomized test cases
b) Constrained Random Testing
The constrained_random_test task produces random test cases:
systemverilog
Copy
Edit
task constrained_random_test();
begin
repeat (10) begin
A = $rand;
B = $rand;
cin = $rand % 2;
#10;
expected_sum = A + B + cin;

assert (s == expected_sum[15:0]) else
$error("Random Test Mismatch: Expected Sum=%b, Got Sum=%b", expected_sum[15:0], s);

assert (co == expected_sum[16]) else
$error("Random Test Mismatch: Expected Cout=%b, Got Cout=%b", expected_sum[16], co);
end
end
endtask
This ensures broader coverage of possible input cases, including random values.

3. Execution Flow
The initial block calls all test tasks:

systemverilog
Copy
Edit
initial begin
$display("Starting Directed Test Cases.");
directed_test_cases();
$display("Directed Tests Completed.");

$display("Starting Constrained Random Testing.");
constrained_random_test();
$display("Random Tests Completed.");

$display("All Tests Finished.");
$stop;
end
How It Verifies the Adder
Directed Tests - Tests pre-defined edge cases (zero, overflow, carry-in).
Random Tests - Introduces randomness in inputs to achieve comprehensive coverage.
Assertions - Verifies sum and carry-out against pre-computed values.
Logging & Error Reporting - Shows mismatches on failure of verification.
Future Enhancements
Run more test iterations for increased coverage
Use functional coverage metrics
Automate dumping of waveforms for debugging
