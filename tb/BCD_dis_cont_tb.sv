`timescale 1ns/1ps
module BCD_display_tb ();
     logic [0:3] [3:0] bcd;
     logic clk;
     logic rst;
     logic error;
     logic [6:0] seg;
     logic  [3:0] select_an;
BCD_display_cont bcd1(.bcd(bcd),.clk(clk),.error(error),.sel_an(select_an),.seven_seg(seg),.rst(rst));
initial begin
    clk=0;//we use blocking assignments here in the testbench
    // because we need it as just a sequential block of code that goes in order
    forever begin
        #5;
        clk=~clk;
    end
end   
task generate_stimulus();
bcd[0]=4'h1;
bcd[1]=4'h2;
bcd[2]=4'h3;
bcd[3]=4'h4;
    #3000000;// the period is 10 ns and for it to reach the  16th bit to make the refresh counter start
    // it needs to pass 2 power 16 cycles and then thats one number to pass the four multiply that number by 4
    // so 4 x 2power 16 x 10ns(period )=3ms
    //then it resets
bcd[0]=4'h5;
bcd[1]=4'h6;
bcd[2]=4'h7;
bcd[3]=4'h8;
#3000000;
endtask
logic  [6:0] exp_out [0:9]='{
        7'b100_0000, // 0: all ON except g
        7'b111_1001, // 1: only b, c ON
        7'b010_0100, // 2: all ON except c, f
        7'b011_0000, // 3: all ON except e, f
        7'b001_1001, // 4: all ON except a, d, e
        7'b001_0010, // 5: all ON except b, e
        7'b000_0010, // 6: all ON except b
        7'b111_1000, // 7: only a, b, c ON
        7'b000_0000, // 8: all ON
        7'b001_0000  // 9: all ON except e
};
always@(select_an)begin// since its a mutiplexed design we have to run it parrallely as there are four multiplexed 7segs
    #1;//If you check the seg output at the exact nanosecond select_an changes,
    // you are checking it before the combinational logic inside your DUT has actually updated the output.
    // Adding #1; allows the signal to settle before the assertion fires.
    case(select_an)
    4'b1110:begin
        assert (seg==exp_out[bcd[0]]&& error==1'b0)// genious shit to make sure it follows the output accross all the iterations 
        $display("the output is matching");
        else   $error("there is a mismatch");
    end
    4'b1101:begin
        assert (seg==exp_out[bcd[1]]&& error==1'b0)// genious shit to make sure it follows the output accross all the iterations 
        $display("the output is matching");
        else   $error("there is a mismatch");
    end
      4'b1011:begin
        assert (seg==exp_out[bcd[2]]&& error==1'b0)// genious shit to make sure it follows the output accross all the iterations 
        $display("the output is matching");
        else   $error("there is a mismatch");
    end
      4'b0111:begin
        assert (seg==exp_out[bcd[3]]&& error==1'b0)// genious shit to make sure it follows the output accross all the iterations 
        $display("the output is matching");
        else   $error("there is a mismatch");
    end
    default:$display("there is an error");
    endcase
end
initial begin
    rst= 1'b1;//reset everything before we get started
    #20;
    rst=1'b0;
    generate_stimulus();
    #100;
    $finish;
end
endmodule