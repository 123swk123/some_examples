package apb3slave.fifo

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba3.apb.{Apb3SlaveFactory, Apb3}

class Fifo(dataWidth: Int) extends BlackBox {
  val io = new Bundle{
    val clk = in Bool()
    val reset = in Bool()
    val dataIn = in UInt(dataWidth bits)
    val writeEn = in Bool()
    val readEn = in Bool()
    val dataOut = out UInt(dataWidth bits)
    val empty = out Bool()
    val full = out Bool()
  }
}

class Apb3Fifo(fifoWidth: Int) extends Component{
  val io = new Bundle{
    val apb = slave(Apb3(addressWidth = 8,dataWidth = 32))
  }

  val apbCtrl = Apb3SlaveFactory(io.apb)
  val baseAddress = 0

  val fifo = new Fifo(fifoWidth)
  fifo.io.clk := ClockDomain.current.readClockWire
  fifo.io.reset := ClockDomain.current.readResetWire
  fifo.io.writeEn := False
  fifo.io.readEn := False
  fifo.io.dataIn := 0

  //when count_1 write happens emit sigOut
  apbCtrl.onWrite(baseAddress + 0) {
    fifo.io.writeEn := True
  }
  apbCtrl.onRead(baseAddress + 0) {
    fifo.io.readEn := True
  }

  apbCtrl.write(fifo.io.dataIn,baseAddress + 0, 0)
  apbCtrl.read(fifo.io.dataOut,baseAddress + 0, 0)

  apbCtrl.read(fifo.io.empty,baseAddress + 4, 0)
  apbCtrl.read(fifo.io.full,baseAddress + 4, 1)
}

object Top {
    def main(args: Array[String]):Unit = {
        SpinalConfig(mode = Verilog, targetDirectory = "out").generate(new Apb3Fifo(8))
    }
}