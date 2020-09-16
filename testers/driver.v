//Init task for clean output signals
task drv_init;
  begin
    @(negedge clk)
      reset = 1;
    @(negedge clk)
      reset = 0;
    @(negedge clk)
      reset = 0;
  end
endtask



//Drive controled sum request
task drv_MODO_request;

input integer iteration;
  MODO = 2'b00;   // start at counter  Q + 3
  repeat (iteration) begin
    @(negedge clk) begin
      D <= D + 1;
      if(RCO) begin
        MODO = MODO + 1;
      end
    end
  end
endtask

//Drive random request
task drv_random_request;

input integer iteration;

  repeat (iteration) begin
    @(negedge clk) begin
      Q <= $random;
      MODO <= $random;
    end
  end
endtask