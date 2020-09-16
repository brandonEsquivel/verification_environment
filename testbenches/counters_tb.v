// Testbench Code Goes here
`include "./src/scoreboard.v"

module counters_tb();

input wire [3:0] Q;
input wire RCO, LOAD, clk;

// from scoreboard
output reg [3:0] sb_Q;
output reg sb_RCO, sb_LOAD;

// Generated signals
output reg RESET, ENABLE;
output reg [3:0] D;
output reg [1:0] MODO;

`include "./testers/driver.v"
`include "./src/checker.v"

parameter ITERATIONS = 100;
integer log;

// WIRES
wire sb_wRCO, sb_wLOAD;
wire [3:0] sb_wQ;

initial begin

  $dumpfile("./test.vcd");
  $dumpvars(0);

  log = $fopen("./log/tb.log");
  $fdisplay(log, "time=%5d, Simulation Start", $time); ////////
  $fdisplay(log, "time=%5d, Starting Reset", $time); ///////

  drv_init();

  $fdisplay(log, "time=%5d, Reset Completed", $time); /////

  $fdisplay(log, "time=%5d, Starting Test", $time);
  fork
    drv_MODO_request(ITERATIONS);
    checker(ITERATIONS);
  join
  $fdisplay(log, "time=%5d, MODO Test Completed", $time);
  $fdisplay(log, "time=%5d, Simulation Completed", $time);

  $fdisplay(log, "time=%5d, Starting Reset", $time); ///////

  drv_init();

  $fdisplay(log, "time=%5d, Reset Completed", $time); /////

  $fdisplay(log, "time=%5d, Starting Random Test", $time);
  fork
    drv_random_request(ITERATIONS);
    checker(ITERATIONS);
  join
  $fdisplay(log, "time=%5d, MODO Test Completed", $time);
  $fdisplay(log, "time=%5d, Simulation Completed", $time);

  $fclose(log);
  #200 $finish;
end

  scoreboard sb(
    //INPUTS
    .clk      (clk),
    .ENABLE   (ENABLE),
    .RESET    (RESET),
    .sb_D     (D),
    .sb_MODO  (MODO),
    // OUTPUTS
    .sb_Q     (sb_wQ),
    .sb_RCO   (sb_wRCO),
    .sb_LOAD  (sb_wLOAD)
  );

  always @(*) begin
    sb_RCO = sb_wRCO;
    sb_LOAD = sb_wLOAD;
    sb_Q = sb_wQ;
  end

endmodule
