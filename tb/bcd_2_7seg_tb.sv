`timescale 1ns/1ps
module bcd_to_7seg_tb();
    typedef struct  {
        logic [3:0] bcd;
        logic [6:0] seg;
        logic error ;
    } transaction;
transaction tr;
bcd_to_7seg inst1(.bcd(tr.bcd),.seg(tr.seg), .err(tr.error));
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
initial begin
    for(int i=0;i<16;i++)begin
        tr.bcd=i[3:0];//driving before th if to avoid that when the i turns to 10 teh bcd will still be 9 and enter the if 
        #10;
        if(tr.bcd<=9)begin
            assert (tr.seg==exp_out[i]&& tr.error==1'b0)// no semicolon after assert only after error
            else   $error("theres an error with with segment");
        end
        else begin
            assert (tr.seg==7'b1111111&& tr.error==1'b1)
            else   $error("theres an error with with segment");
        end
    end
end
endmodule