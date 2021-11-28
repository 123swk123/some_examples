package free_run_counter

import spinal.core._
import spinal.lib._

class PLL extends BlackBox{
    val io = new Bundle{
        val clkIn    = in Bool()
        val clkOut   = out Bool()
        val isLocked = out Bool()
    }
}

class Free_Counter(width: Int) extends Component {
    val io = new Bundle {
        val clk = in Bool()
        val reset = in Bool()
        val count = out UInt(width bits)
    }
    
    val clkCtrl = new Area {
        //Instanciate and drive the PLL
        // val pll = new PLL
        // pll.io.clkIn := io.clk

        //Create a new clock domain named 'core'
        val coreClockDomain = ClockDomain.internal(
        name = "core",
        frequency = FixedFrequency(200 MHz)  // This frequency specification can be used
        )                                      // by coreClockDomain users to do some calculations

        //Drive clock and reset signals of the coreClockDomain previously created
        coreClockDomain.clock := io.clk
        coreClockDomain.reset := io.reset
    }

    //Create a ClockingArea which will be under the effect of the clkCtrl.coreClockDomain
    val core = new ClockingArea(clkCtrl.coreClockDomain){
        //Do your stuff which use coreClockDomain here
        val count = Reg(UInt(width bits)) init(0)
        count := count + 1
        io.count := count
    
    }
}

object Top {
    def main(args: Array[String]):Unit = {
        SpinalConfig(mode = Verilog, targetDirectory = "out").generate(new Free_Counter(16))
    }
}
