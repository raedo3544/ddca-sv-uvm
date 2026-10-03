module BCD_display_cont (
    input  logic clk,
    input  logic rst,
    output logic error,
    output logic [3:0] sel_an,
    input  logic [0:3] [3:0] bcd,
    output logic [6:0] seven_seg
);

    logic [17:0] refresh_counter;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            refresh_counter <= 0;
        end else begin
            refresh_counter <= refresh_counter + 1;
        end
    end

    // Arrays to hold the individual outputs from the 4 decoders
    logic [6:0] decoded_seg [0:3];
    logic [0:3] decoded_err;

    // Generate block to stamp out 4 instances of the bcd_to_7seg decoder
    genvar i;
    generate
        for (i = 0; i < 4; i++) begin : gen_decoders
            bcd_to_7seg decoder_inst (
                .bcd(bcd[i]),
                .seg(decoded_seg[i]),
                .err(decoded_err[i])
            );
        end
    endgenerate

    // Multiplexer now selects the pre-decoded 7-segment outputs and errors
    always_comb begin
        case (refresh_counter[17:16])
            2'b00: begin
                sel_an    = 4'b1110;
                seven_seg = decoded_seg[0];
                error     = decoded_err[0];
            end
            2'b01: begin
                sel_an    = 4'b1101;
                seven_seg = decoded_seg[1];
                error     = decoded_err[1];
            end
            2'b10: begin
                sel_an    = 4'b1011;
                seven_seg = decoded_seg[2];
                error     = decoded_err[2];
            end
            2'b11: begin
                sel_an    = 4'b0111;
                seven_seg = decoded_seg[3];
                error     = decoded_err[3];
            end
            default: begin
                sel_an    = 4'b1111;
                seven_seg = '0;
                error     = 1'b0;
            end
        endcase
    end
endmodule