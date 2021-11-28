package free_run_counter_100hz

import spinal.core._
import spinal.lib._

class Free_Counter(width: Int) extends Component {
    val io = new Bundle {
        val clk = in Bool()
        val reset = in Bool()
        val count = out UInt(width bits)
    }
    
    val timer = Timeout(100 Hz)
    val count = Counter(bitCount = BitCount(width))
    when(timer) {
        timer.clear()
        count.increment()
    }
    io.count := count
}

object Top {
    def main(args: Array[String]):Unit = {
        SpinalConfig(mode = Verilog, defaultClockDomainFrequency = FixedFrequency(100 MHz), targetDirectory = "out").generate(new Free_Counter(16))
    }
}
