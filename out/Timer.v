// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : Timer



module Timer (
  input               io_tick,
  input               io_clear,
  input      [7:0]    io_limit,
  output              io_full,
  input               clk,
  input               reset
);
  reg        [7:0]    counter;
  wire                when_timer_l18;

  assign when_timer_l18 = (io_tick && (! io_full));
  assign io_full = (counter == io_limit);
  always @(posedge clk) begin
    if(when_timer_l18) begin
      counter <= (counter + 8'h01);
    end
    if(io_clear) begin
      counter <= 8'h0;
    end
  end


endmodule
