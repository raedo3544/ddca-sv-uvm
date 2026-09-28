`timescale 1ns/1ps
module full_adder_tb;
typedef struct packed {
   logic [7:0] a,b,cin;
   logic [7:0]sum,cout;
} transaction;
logic exp_out;
logic exp_sum;
transaction tr;
// to drive a module you need the orignal_module_name  current_instance_name( port connections) 
 full_adder fla(.a(tr.a[0]), .b(tr.b[0]), .cin(tr.cin[0]), .sum(tr.sum[0]), .cout(tr.cout[0]));// the outer part is for the original module in the rtl and 
 //the inside one is for the tb the local signal name
function void  generate_stimulus();
    tr.a=8'b11110000;
    tr.b=8'b11001100;
    tr.cin=8'b10101010;
endfunction
function void check_results();
 if(exp_sum==tr.sum[0]&&exp_out==tr.cout[0]) 
    $display("output is correct,the sum equals=%d and the carry_out=%d ",tr.sum[0],tr.cout[0]);
 else begin
    $display("the outputs are not-coherent");
end
endfunction
function void shift_inputs_right();//semicolon after the function header
 tr.a=tr.a>>1;
 tr.b=tr.b>>1;
 tr.cin=tr.cin>>1;
endfunction
initial begin
    generate_stimulus();
    for(int i=0;i<8;i++)begin
    {exp_out,exp_sum} = tr.a[0] + tr.b[0] + tr.cin[0];
    #1;
    check_results();
    shift_inputs_right();
    end
end 
endmodule 
// we cannot write the tr= generat_stimulus(tr) becuase we will overwrite the tr.sum and cout and we cannot do that
// they are overwritten because packed as asingle entity changes together