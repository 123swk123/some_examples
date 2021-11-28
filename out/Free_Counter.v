// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : Free_Counter
// Git hash  : 31087863562c0473dc47ee89df23415140aa18e5



module Free_Counter (
  input               io_clk,
  input               io_reset,
  output     [15:0]   io_count,
  input               clk,
  input               reset
);
  wire       [19:0]   _zz_timer_counter_valueNext;
  wire       [0:0]    _zz_timer_counter_valueNext_1;
  wire       [15:0]   _zz_count_valueNext;
  wire       [0:0]    _zz_count_valueNext_1;
  reg                 timer_state;
  reg                 timer_stateRise;
  wire                timer_counter_willIncrement;
  reg                 timer_counter_willClear;
  reg        [19:0]   timer_counter_valueNext;
  reg        [19:0]   timer_counter_value;
  wire                timer_counter_willOverflowIfInc;
  wire                timer_counter_willOverflow;
  reg                 count_willIncrement;
  wire                count_willClear;
  reg        [15:0]   count_valueNext;
  reg        [15:0]   count_value;
  wire                count_willOverflowIfInc;
  wire                count_willOverflow;

  assign _zz_timer_counter_valueNext_1 = timer_counter_willIncrement;
  assign _zz_timer_counter_valueNext = {19'd0, _zz_timer_counter_valueNext_1};
  assign _zz_count_valueNext_1 = count_willIncrement;
  assign _zz_count_valueNext = {15'd0, _zz_count_valueNext_1};
  always @(*) begin
    timer_stateRise = 1'b0;
    if(timer_counter_willOverflow) begin
      timer_stateRise = (! timer_state);
    end
    if(timer_state) begin
      timer_stateRise = 1'b0;
    end
  end

  always @(*) begin
    timer_counter_willClear = 1'b0;
    if(timer_state) begin
      timer_counter_willClear = 1'b1;
    end
  end

  assign timer_counter_willOverflowIfInc = (timer_counter_value == 20'hf423f);
  assign timer_counter_willOverflow = (timer_counter_willOverflowIfInc && timer_counter_willIncrement);
  always @(*) begin
    if(timer_counter_willOverflow) begin
      timer_counter_valueNext = 20'h0;
    end else begin
      timer_counter_valueNext = (timer_counter_value + _zz_timer_counter_valueNext);
    end
    if(timer_counter_willClear) begin
      timer_counter_valueNext = 20'h0;
    end
  end

  assign timer_counter_willIncrement = 1'b1;
  always @(*) begin
    count_willIncrement = 1'b0;
    if(timer_state) begin
      count_willIncrement = 1'b1;
    end
  end

  assign count_willClear = 1'b0;
  assign count_willOverflowIfInc = (count_value == 16'hffff);
  assign count_willOverflow = (count_willOverflowIfInc && count_willIncrement);
  always @(*) begin
    count_valueNext = (count_value + _zz_count_valueNext);
    if(count_willClear) begin
      count_valueNext = 16'h0;
    end
  end

  assign io_count = count_value;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      timer_state <= 1'b0;
      timer_counter_value <= 20'h0;
      count_value <= 16'h0;
    end else begin
      timer_counter_value <= timer_counter_valueNext;
      if(timer_counter_willOverflow) begin
        timer_state <= 1'b1;
      end
      count_value <= count_valueNext;
      if(timer_state) begin
        timer_state <= 1'b0;
      end
    end
  end


endmodule
