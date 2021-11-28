// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : Apb3Fifo
// Git hash  : 2b96a41b2a824682e59c7e0f67318ab038648694



module Apb3Fifo (
  input      [7:0]    io_apb_PADDR,
  input      [0:0]    io_apb_PSEL,
  input               io_apb_PENABLE,
  output              io_apb_PREADY,
  input               io_apb_PWRITE,
  input      [31:0]   io_apb_PWDATA,
  output reg [31:0]   io_apb_PRDATA,
  output              io_apb_PSLVERROR,
  input               clk,
  input               reset
);
  reg        [7:0]    fifo_1_io_dataIn;
  reg                 fifo_1_io_writeEn;
  reg                 fifo_1_io_readEn;
  wire       [7:0]    fifo_1_io_dataOut;
  wire                fifo_1_io_empty;
  wire                fifo_1_io_full;
  wire                apbCtrl_askWrite;
  wire                apbCtrl_askRead;
  wire                apbCtrl_doWrite;
  wire                apbCtrl_doRead;

  Fifo fifo_1 (
    .io_clk        (clk                ), //i
    .io_reset      (reset              ), //i
    .io_dataIn     (fifo_1_io_dataIn   ), //i
    .io_writeEn    (fifo_1_io_writeEn  ), //i
    .io_readEn     (fifo_1_io_readEn   ), //i
    .io_dataOut    (fifo_1_io_dataOut  ), //o
    .io_empty      (fifo_1_io_empty    ), //o
    .io_full       (fifo_1_io_full     )  //o
  );
  assign io_apb_PREADY = 1'b1;
  always @(*) begin
    io_apb_PRDATA = 32'h0;
    case(io_apb_PADDR)
      8'h0 : begin
        io_apb_PRDATA[7 : 0] = fifo_1_io_dataOut;
      end
      8'h04 : begin
        io_apb_PRDATA[0 : 0] = fifo_1_io_empty;
        io_apb_PRDATA[1 : 1] = fifo_1_io_full;
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
    fifo_1_io_writeEn = 1'b0;
    case(io_apb_PADDR)
      8'h0 : begin
        if(apbCtrl_doWrite) begin
          fifo_1_io_writeEn = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fifo_1_io_readEn = 1'b0;
    case(io_apb_PADDR)
      8'h0 : begin
        if(apbCtrl_doRead) begin
          fifo_1_io_readEn = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fifo_1_io_dataIn = 8'h0;
    case(io_apb_PADDR)
      8'h0 : begin
        if(apbCtrl_doWrite) begin
          fifo_1_io_dataIn = io_apb_PWDATA[7 : 0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule
