package apb3slave.test

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba3.apb.{Apb3SlaveFactory, Apb3}

case class Apb3Test() extends Component{
  val io = new Bundle{
    val apb = slave(Apb3(addressWidth = 8,dataWidth = 32))
    val sigOut = out Bool()
  }

  val apbCtrl = Apb3SlaveFactory(io.apb)
  val baseAddress = 0

  //create a RW register variable
  val count  = apbCtrl.createReadAndWrite(UInt(12 bits) ,baseAddress + 0,0)  init(0)
  val count_1  = apbCtrl.createReadAndWrite(UInt(12 bits) ,baseAddress + 0,12)  init(0)
  
  //when count_1 write happens emit sigOut
  io.sigOut := False
  apbCtrl.onWrite(baseAddress + 0) {
    io.sigOut := True
  }

  val clockCounter = new Area{
    val counter = Reg(UInt(8 bits)) init(0)
    counter := counter + 1
    when(counter > 100) {
      counter := 0
    }
  }

  //associate an existing variable to RO 
  apbCtrl.read(clockCounter.counter,baseAddress + 4)
  when(clockCounter.counter === 0) {
    count := count - 1
  }
}

object Top {
    def main(args: Array[String]):Unit = {
        SpinalConfig(mode = Verilog, targetDirectory = "out").generate(new Apb3Test())
    }
}