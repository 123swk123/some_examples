import spinal.core._
import spinal.lib._

//Hardware definition
class MyAND() extends Component{
    val io = new Bundle{
        val a = in Bool()
        val b = in Bool()
        val c = out Bool()
    }

    io.c := io.a && io.b
}

object Top {
    def main(args: Array[String]):Unit = {
        SpinalConfig(mode = Verilog, targetDirectory = "out").generate(new MyAND())
    }
}
