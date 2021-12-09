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
    
    
    // val regDataIn = Reg(io.dataOut) init(0)
    
    val prescaleCounter = Reg(UInt(4 bits)) init(0)
    val regSCK = Reg(Bool()) init(False)
    val spiDataShiftCounter = Reg(UInt(log2Up(dataWidth+1) bits)) init(dataWidth)
    val regData = Reg(io.dataIn) init(io.dataIn)
    val regDataBit0 = Reg(Bool()) init(False)


    io.sck <> regSCK
    io.mosi <> regData(dataWidth - 1)
    io.dataOut <> regData

    io.cs := ClockDomain.current.readResetWire || !(spiDataShiftCounter > 0) 
    
    prescaleCounter := prescaleCounter + 1
    when(prescaleCounter === 0 && spiDataShiftCounter > 0) {
        prescaleCounter := 0
        regSCK := !regSCK
        
        when(regSCK === True) {
            spiDataShiftCounter := spiDataShiftCounter - 1
            // regData := regData |<< 1
            regData(1 until dataWidth) := regData(0 until dataWidth-1)
        }

        when(regSCK === False) {
            regDataBit0 := io.miso
            regData(0) := regDataBit0
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
