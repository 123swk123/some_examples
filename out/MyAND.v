// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : MyAND



module MyAND (
  input               io_a,
  input               io_b,
  output              io_c
);
  wire                logic_c;
  wire                logic2_c;

  assign logic_c = (io_a && io_b);
  assign logic2_c = (logic_c == 1'b1);
  assign io_c = logic2_c;

endmodule
