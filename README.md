# verification_environment
Implementation of a specific verification environment for three modules called counters A, B and C, in synthesized structural design. It corresponds to an assignment on verification and tests of the course Microelectronics: silicon systems, of the school of electrical engineering of the University of Costa Rica

## Ing. Brandon Esquivel Molina
# UCR

# How to run:

run  $make all   for the complete process.

run  $make v_tb  to compile the testbench.

run  $make run   for simulation and test.

To select the contador"X".v un-comment the instance in top_tb.v to test
 
You can choose the test or task in counters_tb.v at lines 45 and 59. Just add 00, 01, 10 or 11 after MODE in the name of the task to execute.
A general test of all modes and a random test are set by default.
