package and_clockarea
import spinal.core._
import spinal.lib._

//Hardware definition
class MyAND() extends Component{
    val io = new Bundle{
        val sys_clk = in Bool()
        val reset = in Bool()
        val a = in Bool()
        val b = in Bool()
        val c = out Bool()
    }

    val systemDomain = ClockDomain.internal("system")
    // Assign systemDomain signals with something
    systemDomain.clock := io.sys_clk
    systemDomain.reset := io.reset

    val logic = new ClockingArea(systemDomain) {
        val reg_a = Reg(Bool()) init(False)
        val reg_b = Reg(Bool()) init(False)

        reg_a := io.a
        reg_b := io.b
        io.c := reg_a && reg_b
    }
}

object Top {
    def main(args: Array[String]):Unit = {
        SpinalConfig(mode = Verilog, targetDirectory = "out").generate(new MyAND())
    }
}
