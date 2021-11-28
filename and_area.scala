package and_area
import spinal.core._
import spinal.lib._

//Hardware definition
class MyAND() extends Component{
    val io = new Bundle{
        val a = in Bool()
        val b = in Bool()
        val c = out Bool()
    }

    val logic = new Area {
        val c = io.a && io.b
    }

    
    val logic2 = new Area {
        val c = logic.c === True
    }


    io.c := logic2.c
}

object Top {
    def main(args: Array[String]):Unit = {
        SpinalConfig(mode = Verilog, targetDirectory = "out").generate(new MyAND())
    }
}
