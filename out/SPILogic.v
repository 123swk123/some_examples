// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : SPILogic
// Git hash  : a2c265d47e10e286ea5352310bce30526c4924e6



module SPILogic (
  input               io_miso,
  output              io_mosi,
  output              io_sck,
  output reg          io_cs,
  input      [7:0]    io_dataIn,
  output     [7:0]    io_dataOut,
  input               reset,
  input               clk
);
  reg        [3:0]    prescaleCounter;
  reg                 regSCK;
  (* async_reg = "true" *) reg        [3:0]    spiClockFallingLogic_spiDataShiftCounter;
  reg        [7:0]    spiClockFallingLogic_regData;
  wire                when_spi_test_l32;
  reg                 spiClockRisingLogic_regData;
  wire                when_spi_test_l45;
  wire                when_spi_test_l53;

  assign io_sck = regSCK;
  assign io_mosi = spiClockFallingLogic_regData[7];
  assign io_dataOut = spiClockFallingLogic_regData;
  always @(*) begin
    io_cs = 1'b1;
    if(when_spi_test_l32) begin
      io_cs = 1'b0;
    end
  end

  assign when_spi_test_l32 = (4'b0000 < spiClockFallingLogic_spiDataShiftCounter);
  assign when_spi_test_l45 = (4'b0000 < spiClockFallingLogic_spiDataShiftCounter);
  assign when_spi_test_l53 = ((prescaleCounter == 4'b0010) && (4'b0000 < spiClockFallingLogic_spiDataShiftCounter));
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      prescaleCounter <= 4'b0000;
      regSCK <= 1'b0;
    end else begin
      prescaleCounter <= (prescaleCounter + 4'b0001);
      if(when_spi_test_l53) begin
        prescaleCounter <= 4'b0000;
        regSCK <= (! regSCK);
      end
    end
  end

  always @(negedge regSCK or posedge reset) begin
    if(reset) begin
      spiClockFallingLogic_spiDataShiftCounter <= 4'b1000;
      spiClockFallingLogic_regData <= io_dataIn;
    end else begin
      if(when_spi_test_l32) begin
        spiClockFallingLogic_spiDataShiftCounter <= (spiClockFallingLogic_spiDataShiftCounter - 4'b0001);
        spiClockFallingLogic_regData <= (spiClockFallingLogic_regData <<< 1);
      end
      if(when_spi_test_l45) begin
        spiClockFallingLogic_regData[0] <= spiClockRisingLogic_regData;
      end
    end
  end

  always @(posedge regSCK or posedge reset) begin
    if(reset) begin
      spiClockRisingLogic_regData <= 1'b0;
    end else begin
      if(when_spi_test_l45) begin
        spiClockRisingLogic_regData <= io_miso;
      end
    end
  end


endmodule
