package apb3slave.testvec

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

class Apb3TestVec(chCount: Int) extends Component{
  val io = new Bundle{
    val apb = slave(Apb3(addressWidth = 8,dataWidth = 32))
    val sigOut = out Vec(Bool(), chCount)
  }

  val apbCtrl = Apb3SlaveFactory(io.apb)
  val baseAddress = 0

  var fifoLst: List[Fifo] = List()
  for (idx <- 0 until chCount) {
    val fifo = new Fifo(24)
    fifo.io.clk := ClockDomain.current.readClockWire
    fifo.io.reset := ClockDomain.current.readResetWire
    fifo.io.writeEn := False
    fifo.io.readEn := False
    fifo.io.dataIn := 0

    fifoLst = fifoLst :+ fifo
  }

  //create a RW register variable
  val addrOffsets = 0 until (chCount*4, 4)
  var apbCountLst: List[UInt] = List()
  for (addrOffset <- addrOffsets) {
    println(addrOffset)
    val apbCount  = apbCtrl.createReadAndWrite(UInt(12 bits) ,baseAddress + addrOffset,0)  init(0)
    apbCountLst = apbCountLst :+ apbCount
  }
  println(apbCountLst)
  
  val addrDataOffsets = addrOffsets.end until (addrOffsets.end+chCount*4, 4)
  for ((addrOffset, fifo) <- addrDataOffsets.zip(fifoLst)) {
    println(addrOffset)
    apbCtrl.write(fifo.io.dataIn, baseAddress + addrOffset, 0)
    apbCtrl.onWrite(baseAddress + addrOffset) {
      fifo.io.writeEn := True
    }
  }

  io.sigOut.map(_ := False)

  val clockCounter = new Area{
    val counter = Reg(UInt(8 bits)) init(0)
    counter := counter + 1
    when(counter > 100) {
      counter := 0

      for ((apbCount, sigOut) <- apbCountLst.zip(io.sigOut)) {
        apbCount := apbCount - 1

        sigOut.setWhen(apbCount === 0)
      }
    }
  }

}

object Top {
    def main(args: Array[String]):Unit = {
        SpinalConfig(mode = Verilog, targetDirectory = "out").generate(new Apb3TestVec(2)).printPruned()
    }
}