task checker;
// comparing modules outputs with scoreboards inputs

input integer iteration;

  repeat (iteration) @ (posedge clk) begin
	  if ((sb_Q == Q) && (sb_RCO == RCO) && (sb_LOAD == LOAD)) begin
      $fdisplay(log, "PASS ALL"); 
      end
    else begin
      $fdisplay(log, "Time=%.0f Error! DUV: Q=%d, RCO=%b, LOAD=%b, scoreboard: sb_Q=%d, sb_RCO=%b, sb_LOAD=%b", $time, Q, RCO, LOAD, sb_Q, sb_RCO, sb_LOAD);
      end
  end // repeat
endtask
