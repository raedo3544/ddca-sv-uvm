module BCD_display_cont (input logic clk,
input logic rst,
output logic error,
output logic [3:0] sel_an,
input logic [0:3] [3:0] bcd,
output logic [6:0] seven_seg
);
logic [17:0] refresh_counter;
    always_ff@(posedge clk or posedge rst) begin
        if(rst)begin
            refresh_counter<=0;// sequential use the nonblocking assignment
        end
        else begin
        refresh_counter<=refresh_counter+1;
        end
    end
logic [3:0] current_bcd;
    always_comb begin
        case (refresh_counter[17:16])
        2'b00:begin
            sel_an=4'b1110;
            current_bcd=bcd[0];
        end
        2'b01:begin
            sel_an=4'b1101;
            current_bcd=bcd[1];
        end
        2'b10:begin
            sel_an=4'b1011;
            current_bcd=bcd[2];
        end
        2'b11:begin
            sel_an=4'b0111;
            current_bcd=bcd[3];
        end
            default: begin
                sel_an=4'b1111;
                current_bcd='0;// dont forget to assign all the variables to avoid the latch problem
            end
        endcase
    end
    bcd_to_7seg decoder_inst (.bcd(current_bcd), .seg(seven_seg), .err(error));
endmodule