// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : MyAND
// Git hash  : 72a3c8170b2054c4780b3e4095f694296097e8f5



module MyAND (
  input               io_sys_clk,
  input               io_reset,
  input               io_a,
  input               io_b,
  output              io_c
);
  wire                system_clk;
  wire                system_reset;
  reg                 logic_reg_a;
  reg                 logic_reg_b;

  assign system_clk = io_sys_clk;
  assign system_reset = io_reset;
  assign io_c = (logic_reg_a && logic_reg_b);
  always @(posedge system_clk or posedge system_reset) begin
    if(system_reset) begin
      logic_reg_a <= 1'b0;
      logic_reg_b <= 1'b0;
    end else begin
      logic_reg_a <= io_a;
      logic_reg_b <= io_b;
    end
  end


endmodule
