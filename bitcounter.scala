package bit_counter_800khz

import spinal.core._
import spinal.lib._

class BitCounter(bitFreq: HertzNumber, chCount: Int) extends Component {
    val io = new Bundle {
        val enable = in Bool()
        val out_ = out Vec(Bool(), chCount)
    }
    
    val BIT_COUNT_MAX = (ClockDomain.current.frequency.getValue/bitFreq).toInt
    println("BIT_COUNT_MAX", BIT_COUNT_MAX, log2Up(BIT_COUNT_MAX))
    val bitCounter = Reg(UInt(log2Up(BIT_COUNT_MAX) bits)) init(0)
    val bitIndex = Reg(UInt(log2Up(23) bits)) init(0)

    val vecUnitCount = Vec(Reg(UInt(log2Up(2048) bits)) init(0), chCount)
    println(vecUnitCount.toString())

    io.out_.map(_ := False)
    when(io.enable) {
        bitCounter := bitCounter + 1

        when(bitCounter >= BIT_COUNT_MAX) {
            bitCounter := 0
            bitIndex := bitIndex + 1
            when(bitIndex > 23) {
                bitIndex := 0

                // vecUnitCount.map(x => x - 1)
                for((unitCount, out_) <- vecUnitCount.zip(io.out_)) {
                    unitCount := unitCount - 1
                    out_ := True
                }

            }

            // for(index <- vecUnitCount.indices) {
            //     when(vecUnitCount(index) > 0) {
            //         io.out_(index) := True
            //     }
            // }
        }
    }
}

object Top {
    def main(args: Array[String]):Unit = {
        SpinalConfig(mode = Verilog, 
        defaultClockDomainFrequency = FixedFrequency(72 MHz), 
        targetDirectory = "out").generate(new BitCounter(0.8 MHz, 8))
    }
}
