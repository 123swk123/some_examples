// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : Apb3TestVec
// Git hash  : dd3480b4aabd22ac75da038b2f7c08214b8603e8



module Apb3TestVec (
  input      [7:0]    io_apb_PADDR,
  input      [0:0]    io_apb_PSEL,
  input               io_apb_PENABLE,
  output              io_apb_PREADY,
  input               io_apb_PWRITE,
  input      [31:0]   io_apb_PWDATA,
  output reg [31:0]   io_apb_PRDATA,
  output              io_apb_PSLVERROR,
  output reg          io_sigOut_0,
  output reg          io_sigOut_1,
  input               clk,
  input               reset
);
  reg        [23:0]   fifo_1_io_dataIn;
  reg                 fifo_1_io_writeEn;
  reg        [23:0]   fifo_2_io_dataIn;
  reg                 fifo_2_io_writeEn;
  wire       [23:0]   fifo_1_io_dataOut;
  wire                fifo_1_io_empty;
  wire                fifo_1_io_full;
  wire       [23:0]   fifo_2_io_dataOut;
  wire                fifo_2_io_empty;
  wire                fifo_2_io_full;
  wire                apbCtrl_askWrite;
  wire                apbCtrl_askRead;
  wire                apbCtrl_doWrite;
  wire                apbCtrl_doRead;
  reg        [11:0]   _zz_io_apb_PRDATA;
  reg        [11:0]   _zz_io_apb_PRDATA_1;
  reg        [7:0]    clockCounter_counter;
  wire                when_apb3_slave_test_multivec_l65;
  wire                when_apb3_slave_test_multivec_l71;
  wire                when_apb3_slave_test_multivec_l71_1;

  Fifo fifo_1 (
    .io_clk        (clk                ), //i
    .io_reset      (reset              ), //i
    .io_dataIn     (fifo_1_io_dataIn   ), //i
    .io_writeEn    (fifo_1_io_writeEn  ), //i
    .io_readEn     (1'b0               ), //i
    .io_dataOut    (fifo_1_io_dataOut  ), //o
    .io_empty      (fifo_1_io_empty    ), //o
    .io_full       (fifo_1_io_full     )  //o
  );
  Fifo fifo_2 (
    .io_clk        (clk                ), //i
    .io_reset      (reset              ), //i
    .io_dataIn     (fifo_2_io_dataIn   ), //i
    .io_writeEn    (fifo_2_io_writeEn  ), //i
    .io_readEn     (1'b0               ), //i
    .io_dataOut    (fifo_2_io_dataOut  ), //o
    .io_empty      (fifo_2_io_empty    ), //o
    .io_full       (fifo_2_io_full     )  //o
  );
  assign io_apb_PREADY = 1'b1;
  always @(*) begin
    io_apb_PRDATA = 32'h0;
    case(io_apb_PADDR)
      8'h0 : begin
        io_apb_PRDATA[11 : 0] = _zz_io_apb_PRDATA;
      end
      8'h04 : begin
        io_apb_PRDATA[11 : 0] = _zz_io_apb_PRDATA_1;
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
      8'h08 : begin
        if(apbCtrl_doWrite) begin
          fifo_1_io_writeEn = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fifo_1_io_dataIn = 24'h0;
    case(io_apb_PADDR)
      8'h08 : begin
        if(apbCtrl_doWrite) begin
          fifo_1_io_dataIn = io_apb_PWDATA[23 : 0];
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fifo_2_io_writeEn = 1'b0;
    case(io_apb_PADDR)
      8'h0c : begin
        if(apbCtrl_doWrite) begin
          fifo_2_io_writeEn = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fifo_2_io_dataIn = 24'h0;
    case(io_apb_PADDR)
      8'h0c : begin
        if(apbCtrl_doWrite) begin
          fifo_2_io_dataIn = io_apb_PWDATA[23 : 0];
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_sigOut_0 = 1'b0;
    if(when_apb3_slave_test_multivec_l65) begin
      if(when_apb3_slave_test_multivec_l71) begin
        io_sigOut_0 = 1'b1;
      end
    end
  end

  always @(*) begin
    io_sigOut_1 = 1'b0;
    if(when_apb3_slave_test_multivec_l65) begin
      if(when_apb3_slave_test_multivec_l71_1) begin
        io_sigOut_1 = 1'b1;
      end
    end
  end

  assign when_apb3_slave_test_multivec_l65 = (8'h64 < clockCounter_counter);
  assign when_apb3_slave_test_multivec_l71 = (_zz_io_apb_PRDATA == 12'h0);
  assign when_apb3_slave_test_multivec_l71_1 = (_zz_io_apb_PRDATA_1 == 12'h0);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      _zz_io_apb_PRDATA <= 12'h0;
      _zz_io_apb_PRDATA_1 <= 12'h0;
      clockCounter_counter <= 8'h0;
    end else begin
      clockCounter_counter <= (clockCounter_counter + 8'h01);
      if(when_apb3_slave_test_multivec_l65) begin
        clockCounter_counter <= 8'h0;
        _zz_io_apb_PRDATA <= (_zz_io_apb_PRDATA - 12'h001);
        _zz_io_apb_PRDATA_1 <= (_zz_io_apb_PRDATA_1 - 12'h001);
      end
      case(io_apb_PADDR)
        8'h0 : begin
          if(apbCtrl_doWrite) begin
            _zz_io_apb_PRDATA <= io_apb_PWDATA[11 : 0];
          end
        end
        8'h04 : begin
          if(apbCtrl_doWrite) begin
            _zz_io_apb_PRDATA_1 <= io_apb_PWDATA[11 : 0];
          end
        end
        default : begin
        end
      endcase
    end
  end


endmodule
