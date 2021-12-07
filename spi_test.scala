package spi_test

import spinal.core._
import spinal.lib._

class SPILogic(dataWidth: Int) extends Component {
    val io = new Bundle {
        val miso = in Bool()
        val mosi = out Bool()
        val sck = out Bool()
        val cs = out Bool()
        val dataIn = in UInt(dataWidth bits)
        val dataOut = out UInt(dataWidth bits)
    }
    
    val regData = Reg(io.dataIn) init(io.dataIn)
    // val regDataIn = Reg(io.dataOut) init(0)
    val spiDataWidth = Reg(UInt(log2Up(dataWidth) bits)) init(dataWidth - 1)
    val prescaleCounter = Reg(UInt(4 bits)) init(0)
    val regSCK = Reg(Bool()) init(False)

    io.sck <> regSCK
    io.mosi <> regData(dataWidth - 1)
    io.miso <> regData(0)
    io.dataOut <> regData
    io.cs := True

    prescaleCounter := prescaleCounter + 1
    when(prescaleCounter === 1) {
        prescaleCounter := 0
        regSCK := !regSCK

        when(spiDataWidth > 0) {
            io.cs := False
            spiDataWidth := spiDataWidth - 1
            regData := regData |<< 1
            // regDataIn := regDataIn |>> 1
        }
    }
}

object Top {
    def main(args: Array[String]):Unit = {
        SpinalConfig(mode = Verilog, 
        defaultClockDomainFrequency = FixedFrequency(72 MHz), 
        targetDirectory = "out").generate(new SPILogic(dataWidth = 8))
    }
}
