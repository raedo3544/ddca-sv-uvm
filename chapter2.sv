// there are two ways of constructs in rtl :continusous assignment(assign) and always procedural statements
//assign can represent a simple combinational logic
//procedural block: A procedural 
//block encapsulates one or more lines of programming statements, along with infor
//mation about when the statements should be executed. There are four types of always 
//procedures that are used at the RTL level: always, always_comb, always_ff and always_latch

//An always procedure is an infinite loop. When the 
//procedure has completed execution of the last statement in the procedure, the proce
//dure automatically returns to the beginning, and starts the procedure again. For RTL 
//modeling, an always procedure must begin with a sensitivity list, such as the 
//@(posedge elk)

//NOTE:Modifying and reading a value at the same instant of time is referred to as a simula
//tion race condition.
//Using the opposite edge of the design clock to drive stimulus is a 
//simple way for a testbench to avoid simulation race conditions with the design, such 
//as meeting design setup and hold time requirements

//The nonblocking assignment is represented with a less-than-equal sign (<=), 
//and is used to model sequential logic, such as latches and flip flops. Blocking assign
//ments are scheduled in the Active event region. Nonblocking assignments are sched
//uled for the right-hand side to be evaluated in the Active event region, and the left- 
//hand side to be updated in the NBA Update region. (NBA stands for nonblocking 
//assignment).

//If you have multiple flip-flops in your FPGA design, 
//they are all triggered by the exact same clock edge. 
//If you used a standard blocking assignment (=), 
//the simulation software would evaluate and update variables one by one in a random sequence,
//which can cause reading and writing at the same time—known as a simulation race condition (Page 20)

// a sequential circuit depends on the previous and current inputs not current only
// minterm is a product that involves all of the inputs
//maxterm is the sum  of all the inputs

//SystemVerilog states that while a variable can only be driven by a single source, 
//any number of procedural assignments to the same variable within the same procedural block is considered a single source

//The Single-Driver Rule for logic Variables: In Chapter 3, Section 3.4.3 (page 74) of Stuart Sutherland's book and 
//Chapter 2, Section 2.1.1 (page 26) of Chris Spear's book, 
//a logic variable is only allowed to be driven by one single source. 
//If a variable is connected to the output port of a module instance, 
//it is illegal to also assign a value to that same variable inside an initial procedural block.

//Case statements
//NOTE: if all cases are mutually exclusive (two cases never happen at the same time)
//the synthesis device transform them instead of a priority gate like in the (if else if ) chain
//into a multiplexer (lut) of 2 power n where n are the number of bits in the case 
// saving power and time to access and the lut is like a memory that uses the bits 
//of the case as the memory address for the result of the case for example
//case(2bit)begin
//01: result=64
// the synthesiser makes the 01 the address for the lut and the value stored in that lut is 64


// if a value is left unchanged or unassigned it turns into a latch to save its last value until its called again
// and thats slower than an lut so remember this always

 
//Sutherland's Takeaway: In RTL Modeling with SystemVerilog, unique case acts as a free safety net.
// Even when Vivado is smart enough to optimize a simple constant table on its own, 
//adding unique guarantees that QuestaSim will yell at you if a copy-paste typo ever creates duplicate 
//or missing branches

//MID Project: 4 seven segements low anode 
//clock period is 5ms 
