// Scoreboard ---
// This code do not need to be RTL. No synthesis rules.

module scoreboard (
  // inputs
  input wire ENABLE, RESET, clk,
  input wire [3:0] sb_D,
  input wire [1:0] sb_MODO,
  //outputs
  output reg [3:0]   sb_Q,
  output reg sb_RCO, sb_LOAD

);


reg [1:0] MODO;

  // saving actual state of operation mode
  always@(*) begin
    MODO = sb_MODO;
  end




  always @(posedge clk) begin
    if (RESET) begin
      sb_Q <= 0;
      sb_LOAD <= 0;
      sb_RCO <= 0;
      end else begin
        if(ENABLE) begin

          case ({MODO})
            2'b00: begin
              if(sb_Q == 15 || sb_Q >=13 /*4'b1011*/ ) begin
                sb_RCO <= 1'b1;
                sb_Q <= sb_Q[3:0] + 4'b0011;
                sb_LOAD <= 0;
              end else begin
                sb_Q <= sb_Q[3:0] + 4'b0011;
                sb_LOAD <= 0;
                sb_RCO <= 1'b0;
              end
            end

            2'b01: begin
                if(sb_Q == 4'b0000 ) begin
                  sb_RCO <=  1'b1;
                  sb_Q <= sb_Q[3:0] - 4'b0001;
                  sb_LOAD <= 0;
                end else begin
                  sb_Q <= sb_Q[3:0] - 4'b0001;
                  sb_LOAD <= 0;
                  sb_RCO <=  1'b0;
                end
            end

            2'b10: begin
                if(sb_Q == 4'b1111 ) begin
                  sb_RCO <=  1'b1;
                  sb_Q <= sb_Q[3:0] + 4'b0001;
                  sb_LOAD <= 0;
                end else begin
                  sb_Q <= sb_Q[3:0] + 4'b0001;
                  sb_LOAD <= 0;
                  sb_RCO <=  1'b0;
                end
            end

            2'b11: begin
              sb_RCO <= 0;
              sb_Q <= sb_D;
              sb_LOAD <= 1;
            end

            default: begin
              sb_RCO <= 0;
              sb_Q <= 0;
              sb_LOAD <= 0;
            end

          endcase
        end
        else begin  // ENABLE == 0 & RESET == 0
          sb_Q <= 4'bzzzz;    //////////////////////////////////////////////// H-I ZZZZZZZZZZZZZ
        end
      end
    end
endmodule

