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