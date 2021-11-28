package mylib

import spinal.core._
import spinal.lib._

import scala.util.Random

//Hardware definition
class Timer(width : Int) extends Component{
    val io = new Bundle{
        val tick = in Bool()
        val clear = in Bool()
        val limit = in UInt(width bits)
        val full = out Bool()
    }

    val counter = Reg(UInt(width bits))
    when(io.tick && !io.full){
        counter := counter + 1
    }
    when(io.clear){
        counter := 0
    }
    io.full := counter === io.limit
}
//Generate the MyTopLevel's Verilog
object TopTimerVerilog {
  def main(args: Array[String]):Unit = {
    SpinalConfig(targetDirectory = "out").generateVerilog(new Timer(8))
  }
}