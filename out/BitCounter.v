// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : BitCounter
// Git hash  : 9acf62709958f42d3cfa4d86cba5a59be3f05309



module BitCounter (
  input               io_enable,
  output reg          io_out__0,
  output reg          io_out__1,
  output reg          io_out__2,
  output reg          io_out__3,
  output reg          io_out__4,
  output reg          io_out__5,
  output reg          io_out__6,
  output reg          io_out__7,
  input               clk,
  input               reset
);
  reg        [6:0]    bitCounter_1;
  reg        [4:0]    bitIndex;
  reg        [10:0]   vecUnitCount_0;
  reg        [10:0]   vecUnitCount_1;
  reg        [10:0]   vecUnitCount_2;
  reg        [10:0]   vecUnitCount_3;
  reg        [10:0]   vecUnitCount_4;
  reg        [10:0]   vecUnitCount_5;
  reg        [10:0]   vecUnitCount_6;
  reg        [10:0]   vecUnitCount_7;
  wire                when_bitcounter_l24;
  wire                when_bitcounter_l27;

  always @(*) begin
    io_out__0 = 1'b0;
    if(io_enable) begin
      if(when_bitcounter_l24) begin
        if(when_bitcounter_l27) begin
          io_out__0 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    io_out__1 = 1'b0;
    if(io_enable) begin
      if(when_bitcounter_l24) begin
        if(when_bitcounter_l27) begin
          io_out__1 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    io_out__2 = 1'b0;
    if(io_enable) begin
      if(when_bitcounter_l24) begin
        if(when_bitcounter_l27) begin
          io_out__2 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    io_out__3 = 1'b0;
    if(io_enable) begin
      if(when_bitcounter_l24) begin
        if(when_bitcounter_l27) begin
          io_out__3 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    io_out__4 = 1'b0;
    if(io_enable) begin
      if(when_bitcounter_l24) begin
        if(when_bitcounter_l27) begin
          io_out__4 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    io_out__5 = 1'b0;
    if(io_enable) begin
      if(when_bitcounter_l24) begin
        if(when_bitcounter_l27) begin
          io_out__5 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    io_out__6 = 1'b0;
    if(io_enable) begin
      if(when_bitcounter_l24) begin
        if(when_bitcounter_l27) begin
          io_out__6 = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    io_out__7 = 1'b0;
    if(io_enable) begin
      if(when_bitcounter_l24) begin
        if(when_bitcounter_l27) begin
          io_out__7 = 1'b1;
        end
      end
    end
  end

  assign when_bitcounter_l24 = (7'h5a <= bitCounter_1);
  assign when_bitcounter_l27 = (5'h17 < bitIndex);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      bitCounter_1 <= 7'h0;
      bitIndex <= 5'h0;
      vecUnitCount_0 <= 11'h0;
      vecUnitCount_1 <= 11'h0;
      vecUnitCount_2 <= 11'h0;
      vecUnitCount_3 <= 11'h0;
      vecUnitCount_4 <= 11'h0;
      vecUnitCount_5 <= 11'h0;
      vecUnitCount_6 <= 11'h0;
      vecUnitCount_7 <= 11'h0;
    end else begin
      if(io_enable) begin
        bitCounter_1 <= (bitCounter_1 + 7'h01);
        if(when_bitcounter_l24) begin
          bitCounter_1 <= 7'h0;
          bitIndex <= (bitIndex + 5'h01);
          if(when_bitcounter_l27) begin
            bitIndex <= 5'h0;
            vecUnitCount_0 <= (vecUnitCount_0 - 11'h001);
            vecUnitCount_1 <= (vecUnitCount_1 - 11'h001);
            vecUnitCount_2 <= (vecUnitCount_2 - 11'h001);
            vecUnitCount_3 <= (vecUnitCount_3 - 11'h001);
            vecUnitCount_4 <= (vecUnitCount_4 - 11'h001);
            vecUnitCount_5 <= (vecUnitCount_5 - 11'h001);
            vecUnitCount_6 <= (vecUnitCount_6 - 11'h001);
            vecUnitCount_7 <= (vecUnitCount_7 - 11'h001);
          end
        end
      end
    end
  end


endmodule
