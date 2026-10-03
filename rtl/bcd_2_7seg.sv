//the 7 seg are wired common cathode so all the bins are wired to the cathode of the diodes not the anode 
//so its reversed
module bcd_to_7seg(
    input logic [3:0] bcd,
    output logic [6:0] seg,
    output logic err
);
typedef struct packed {
    logic g;
    logic f;
    logic e;
    logic d;
    logic c;
    logic b;
    logic a;
} seg_t;
seg_t s;
assign seg= s;
 always_comb begin
    err=1'b0;
    unique case (bcd)
        4'd0 :begin
            s='0; // Turns ALL 7 segments ON (0) except g
            s.g=1'b1;
        end 
        4'd1:begin
            s='1;
            s.b=1'b0;
            s.c=1'b0;
        end
        4'd2:begin//all on except c and f
            s='0;
            s.f=1'b1;
            s.c=1'b1;
        end
        4'd3:begin//all on except e and  f
            s='0;
            s.f=1'b1;
            s.e=1'b1;
        end
        4'd4:begin//all on except d,e,a
        s='0;
        s.e=1'b1;
        s.d=1'b1;
        s.a=1'b1;    
        end
        4'd5:begin//all on except b and e
            s='0;
            s.e=1'b1;
            s.b=1'b1;
        end
        4'd6:begin//all on except b
            s='0;
            s.b=1'b1;
        end
        4'd7:begin//all off except a,b,c
            s='1;
            {s.a,s.b,s.c}=3'b0;
        end
        4'd8:begin//all on
            s='0;
        end
        4'd9:begin//all on except e
            s='0;
            s.e=1'b1;
        end
        default: begin err=1'b1;
        s='1;
        end
    endcase
 end
endmodule