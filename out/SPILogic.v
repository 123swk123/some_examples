// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : SPILogic
// Git hash  : 7a117b0f0ada4ec85a7923e27673f8896e646112



module SPILogic (
  input               io_miso,
  output              io_mosi,
  output              io_sck,
  output              io_cs,
  input      [7:0]    io_dataIn,
  output     [7:0]    io_dataOut,
  input               reset,
  input               clk
);
  reg        [3:0]    prescaleCounter;
  reg                 regSCK;
  reg        [3:0]    spiDataShiftCounter;
  reg        [7:0]    regData;
  reg                 regDataBit0;
  wire                when_spi_test_l54;
  wire                when_spi_test_l58;
  wire                when_spi_test_l64;

  assign io_sck = regSCK;
  assign io_mosi = regData[7];
  assign io_dataOut = regData;
  assign io_cs = (reset || (! (4'b0000 < spiDataShiftCounter)));
  assign when_spi_test_l54 = ((prescaleCounter == 4'b0000) && (4'b0000 < spiDataShiftCounter));
  assign when_spi_test_l58 = (regSCK == 1'b1);
  assign when_spi_test_l64 = (regSCK == 1'b0);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      prescaleCounter <= 4'b0000;
      regSCK <= 1'b0;
      spiDataShiftCounter <= 4'b1000;
      regData <= io_dataIn;
      regDataBit0 <= 1'b0;
    end else begin
      prescaleCounter <= (prescaleCounter + 4'b0001);
      if(when_spi_test_l54) begin
        prescaleCounter <= 4'b0000;
        regSCK <= (! regSCK);
        if(when_spi_test_l58) begin
          spiDataShiftCounter <= (spiDataShiftCounter - 4'b0001);
          regData[7 : 1] <= regData[6 : 0];
        end
        if(when_spi_test_l64) begin
          regDataBit0 <= io_miso;
          regData[0] <= regDataBit0;
        end
      end
    end
  end


endmodule
