// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : Apb3Test



module Apb3Test (
  input      [7:0]    io_apb_PADDR,
  input      [0:0]    io_apb_PSEL,
  input               io_apb_PENABLE,
  output              io_apb_PREADY,
  input               io_apb_PWRITE,
  input      [31:0]   io_apb_PWDATA,
  output reg [31:0]   io_apb_PRDATA,
  output              io_apb_PSLVERROR,
  output reg          io_sigOut,
  input               clk,
  input               reset
);
  wire                apbCtrl_askWrite;
  wire                apbCtrl_askRead;
  wire                apbCtrl_doWrite;
  wire                apbCtrl_doRead;
  reg        [11:0]   count;
  reg        [11:0]   count_1;
  reg        [7:0]    clockCounter_counter;
  wire                when_apb3_slave_test_l29;
  wire                when_apb3_slave_test_l36;

  assign io_apb_PREADY = 1'b1;
  always @(*) begin
    io_apb_PRDATA = 32'h0;
    case(io_apb_PADDR)
      8'h0 : begin
        io_apb_PRDATA[11 : 0] = count;
        io_apb_PRDATA[23 : 12] = count_1;
      end
      8'h04 : begin
        io_apb_PRDATA[7 : 0] = clockCounter_counter;
      end
      default : begin
      end
    endcase
  end

  assign io_apb_PSLVERROR = 1'b0;
  assign apbCtrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign apbCtrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign apbCtrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign apbCtrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  always @(*) begin
    io_sigOut = 1'b0;
    case(io_apb_PADDR)
      8'h0 : begin
        if(apbCtrl_doWrite) begin
          io_sigOut = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_apb3_slave_test_l29 = (8'h64 < clockCounter_counter);
  assign when_apb3_slave_test_l36 = (clockCounter_counter == 8'h0);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      count <= 12'h0;
      count_1 <= 12'h0;
      clockCounter_counter <= 8'h0;
    end else begin
      clockCounter_counter <= (clockCounter_counter + 8'h01);
      if(when_apb3_slave_test_l29) begin
        clockCounter_counter <= 8'h0;
      end
      if(when_apb3_slave_test_l36) begin
        count <= (count - 12'h001);
      end
      case(io_apb_PADDR)
        8'h0 : begin
          if(apbCtrl_doWrite) begin
            count <= io_apb_PWDATA[11 : 0];
            count_1 <= io_apb_PWDATA[23 : 12];
          end
        end
        default : begin
        end
      endcase
    end
  end


endmodule
