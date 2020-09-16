`include "./src/clock.v"
`include "./syn/contadorA.v"
`include "./syn/contadorB.v"
`include "./syn/contadorC.v"
`include "./testbenches/counters_tb.v"


`ifndef TB_TOP
`define TB_TOP


module tb_top;

clk clock (.clock (clock));

// WIRES
wire RESET, ENABLE, RCO, sb_RCO, LOAD, sb_LOAD, clock;
wire [3:0] D, Q, sb_Q;
wire [1:0] MODO;

counters_tb tb(
 //OUTPUTS
.RESET      (RESET),
.ENABLE     (ENABLE),
.D          (D),
.MODO       (MODO),

.sb_RCO     (sb_RCO),
.sb_LOAD    (sb_LOAD),
.sb_Q       (sb_Q),
//INPUTS
.Q          (Q),
.RCO        (RCO),
.LOAD       (LOAD),
.clk        (clock)
);

counterA dut (
.clk        (clock),
.reset      (RESET),
.enable     (ENABLE),
.mode       (MODO),
.D          (D),
.load       (LOAD),
.rco        (RCO),
.Q          (Q)
);

endmodule

// Local Variables:
// verilog-library-directories:("."):
// End:
`endif