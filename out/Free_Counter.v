// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : Free_Counter



module Free_Counter (
  input               io_clk,
  input               io_reset,
  output     [15:0]   io_count
);
  wire                core_clk;
  wire                core_reset;
  reg        [15:0]   core_count;

  assign core_clk = io_clk;
  assign core_reset = io_reset;
  assign io_count = core_count;
  always @(posedge core_clk or posedge core_reset) begin
    if(core_reset) begin
      core_count <= 16'h0;
    end else begin
      core_count <= (core_count + 16'h0001);
    end
  end


endmodule
