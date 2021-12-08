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


    val spiClockFallingLogic = new ClockingArea(ClockDomain(regSCK, ClockDomain.current.readResetWire, config = ClockDomainConfig(FALLING))) {
        val spiDataShiftCounter = Reg(UInt(log2Up(dataWidth+1) bits)) init(dataWidth) addTag(crossClockDomain)
        val regData = Reg(io.dataIn) init(io.dataIn)

        io.sck <> regSCK
        io.mosi <> regData(dataWidth - 1)
        io.dataOut <> regData
        io.cs := True

        when(spiDataShiftCounter > 0) {
            io.cs := False
            spiDataShiftCounter := spiDataShiftCounter - 1
            regData := regData |<< 1
            // regDataIn := regDataIn |>> 1
        }
    }

    val spiClockRisingLogic = new ClockingArea(ClockDomain(regSCK, ClockDomain.current.readResetWire, 
                                                config = ClockDomainConfig(RISING))) {

        val regData = Reg(Bool()) init(False)

        when(spiClockFallingLogic.spiDataShiftCounter > 0) {
            regData := io.miso
            spiClockFallingLogic.regData(0) := regData
        }

    }

    prescaleCounter := prescaleCounter + 1
    when(prescaleCounter === 2 && spiClockFallingLogic.spiDataShiftCounter > 0) {
        prescaleCounter := 0
        regSCK := !regSCK
    }
}

object Top {
    def main(args: Array[String]):Unit = {
        SpinalConfig(mode = Verilog, 
        defaultClockDomainFrequency = FixedFrequency(72 MHz), 
        targetDirectory = "out").generate(new SPILogic(dataWidth = 8))
    }
}
