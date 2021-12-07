// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : SPILogic
// Git hash  : fa37f1d56c860bee9c1314f639f6a0a07f656b93



module SPILogic (
  input               io_miso,
  output              io_mosi,
  output              io_sck,
  output reg          io_cs,
  input      [7:0]    io_dataIn,
  output     [7:0]    io_dataOut,
  input               clk,
  input               reset
);
  reg        [7:0]    regData;
  reg        [2:0]    spiDataWidth;
  reg        [3:0]    prescaleCounter;
  reg                 regSCK;
  wire                when_spi_test_l29;
  wire                when_spi_test_l33;

  assign io_sck = regSCK;
  assign io_mosi = regData[7];
  assign io_dataOut = regData;
  always @(*) begin
    io_cs = 1'b1;
    if(when_spi_test_l29) begin
      if(when_spi_test_l33) begin
        io_cs = 1'b0;
      end
    end
  end

  assign when_spi_test_l29 = (prescaleCounter == 4'b0001);
  assign when_spi_test_l33 = (3'b000 < spiDataWidth);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      regData <= io_dataIn;
      spiDataWidth <= 3'b111;
      prescaleCounter <= 4'b0000;
      regSCK <= 1'b0;
    end else begin
      regData[0] <= io_miso;
      prescaleCounter <= (prescaleCounter + 4'b0001);
      if(when_spi_test_l29) begin
        prescaleCounter <= 4'b0000;
        regSCK <= (! regSCK);
        if(when_spi_test_l33) begin
          spiDataWidth <= (spiDataWidth - 3'b001);
          regData <= (regData <<< 1);
        end
      end
    end
  end


endmodule
