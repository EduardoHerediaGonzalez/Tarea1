// Code your testbench here
// or browse Examples
module testbench;
  
  //Local parameters
  localparam D_BUS_WIDTH = 4;
  localparam C_BUS_WIDTH = 4;
  localparam TOTAL_OF_CYCLES_TO_SHOW_DATA = 5;
  localparam TOTAL_OF_CLK_CYCLES = 10;
  
  bit clk;
  reg [(D_BUS_WIDTH - 1):0] test_data1;
  reg [(D_BUS_WIDTH - 1):0] test_data2;
  reg [(D_BUS_WIDTH - 1):0] result;
  reg [(C_BUS_WIDTH - 1):0] test_data3;
  integer cycle_clk_counter = 0;
  
  ALU #(.D_BUS_WIDTH(D_BUS_WIDTH), .C_BUS_WIDTH(C_BUS_WIDTH)) alu(
    .operand_A(test_data1),
    .operand_B(test_data2),
    .opcode(test_data3),
    .result(result)
  );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  //Process that generate a clock pulse
  always begin
    #10 clk = ~clk;
    //$display("Time: %t Clock state: %d", $time, clk);
  end
  

  //Infinity Process 1
  always @(posedge clk) begin
    if (cycle_clk_counter < TOTAL_OF_CYCLES_TO_SHOW_DATA) begin
      #2 std::randomize(test_data1);
      
      $display("Test data 1: %d", test_data1);
      $display();
    end
  end
  
  //Infinity Process 2
  always @(posedge clk) begin
    if (cycle_clk_counter < TOTAL_OF_CYCLES_TO_SHOW_DATA) begin
      #1 std::randomize(test_data2);
      
      $display("Test data 2: %d", test_data2);
    end
  end
  
  //Infinity Process 3
  always @(posedge clk) begin
    if (cycle_clk_counter < TOTAL_OF_CYCLES_TO_SHOW_DATA) begin
      std::randomize(test_data3);
      
      $display("# Clock pulse: %0d", cycle_clk_counter + 1);
      $display("Test data 3: %d", test_data3);
    end
  end
  
  //Infinity Process 4
  always @(posedge clk) begin
    cycle_clk_counter = cycle_clk_counter + 1;
    
    if(cycle_clk_counter > TOTAL_OF_CLK_CYCLES)
    	$stop;
  end
  
endmodule