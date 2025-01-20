module vending_mach (
    input clk,
    input reset,
    input Fiverupee,
    input Lemonwater,
    input [4:0] Lemonwater_added,
    input Sodabottle,
    input [4:0] Sodabottle_added,
    input Tenrupee,
    input Waterbottle,
    input [4:0] Waterbottle_added,
    input cancel,
    output reg [4:0] Lemonwater_available,
    output reg [4:0] Sodabottle_available,
    output reg [4:0] Waterbottle_available,
    output reg [4:0] coincount,
    output reg [1:0] product,
    output reg give,
    output reg [4:0] change
);

    parameter IDLE          = 5'd0;
    parameter ITEM0_IN0     = 5'd1;
    parameter ITEM1_IN1     = 5'd2;
    parameter ITEM2_IN2     = 5'd3;
    parameter WAITING0      = 5'd4;
    parameter WAITING1      = 5'd5;
    parameter WAITING2      = 5'd6;
    parameter ST0           = 5'd7;
    parameter ST1           = 5'd8;
    parameter ST2           = 5'd9;
    parameter ST3           = 5'd10;
    parameter ST4           = 5'd11;
    parameter ST5           = 5'd12;
    parameter WATERBOTTLE   = 5'd13;
    parameter SODABOTTLE    = 5'd14;
    parameter LEMONWATER    = 5'd15;
    parameter CANCEL        = 5'd31;

    parameter WATERBOTTLE_COST = 5'd15;
    parameter SODABOTTLE_COST  = 5'd20;
    parameter LEMONWATER_COST  = 5'd25;

    reg [4:0] current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            coincount <= 5'd0;
            change <= 5'd0;
            give <= 1'b0;
            product <= 2'b00;
        end else begin
            current_state = next_state;

            case (current_state)
                IDLE: begin
                    product <= 2'b00;
                    change <= 5'd0;
                    give <= 1'b0;

                    if (Waterbottle)
                        next_state <= ITEM0_IN0;
                    else if (Sodabottle)
                        next_state <= ITEM1_IN1;
                    else if (Lemonwater)
                        next_state <= ITEM2_IN2;
                    else
                        next_state <= IDLE;
                end

                ITEM0_IN0: begin
                    if (Waterbottle_added > 0)
                        next_state <= WAITING0;
                    else
                        next_state <= IDLE;
                end

                ITEM1_IN1: begin
                    if (Sodabottle_added > 0)
                        next_state <= WAITING1;
                    else
                        next_state <= IDLE;
                end

                ITEM2_IN2: begin
                    if (Lemonwater_added > 0)
                        next_state <= WAITING2;
                    else
                        next_state <= IDLE;
                end

                WAITING0: begin
                    if (cancel) begin
                        change <= coincount;
                        next_state <= CANCEL;
                    end else if (coincount >= WATERBOTTLE_COST) begin
                        next_state <= WATERBOTTLE;
                    end else if (Fiverupee) begin
                        next_state <= ST0;
                    end else if (Tenrupee) begin
                        next_state <= ST1;
                    end
                end

                WAITING1: begin
                    if (cancel) begin
                        change <= coincount;
                        next_state <= CANCEL;
                    end else if (coincount >= SODABOTTLE_COST) begin
                        next_state <= SODABOTTLE;
                    end else if (Fiverupee) begin
                        next_state <= ST2;
                    end else if (Tenrupee) begin
                        next_state <= ST3;
                    end
                end

                WAITING2: begin
                    if (cancel) begin
                        change <= coincount;
                        next_state <= CANCEL;
                    end else if (coincount >= LEMONWATER_COST) begin
                        next_state <= LEMONWATER;
                    end else if (Fiverupee) begin
                        next_state <= ST4;
                    end else if (Tenrupee) begin
                        next_state <= ST5;
                    end
                end

                ST0: begin
                    coincount <= coincount + 5'd5;
                    next_state <= WAITING0;
                end

                ST1: begin
                    coincount <= coincount + 5'd10;
                    next_state <= WAITING0;
                end

                ST2: begin
                    coincount <= coincount + 5'd5;
                    next_state <= WAITING1;
                end

                ST3: begin
                    coincount <= coincount + 5'd10;
                    next_state <= WAITING1;
                end

                ST4: begin
                    coincount <= coincount + 5'd5;
                    next_state <= WAITING2;
                end

                ST5: begin
                    coincount <= coincount + 5'd10;
                    next_state <= WAITING2;
                end

                WATERBOTTLE: begin
                    product <= 2'b01;
                    change <= coincount - WATERBOTTLE_COST;
                    coincount <= 5'd0;
                    next_state <= IDLE;
                end

                SODABOTTLE: begin
                    product <= 2'b10;
                    change <= coincount - SODABOTTLE_COST;
                    coincount <= 5'd0;
                    next_state <= IDLE;
                end

                LEMONWATER: begin
                    product <= 2'b11;
                    change <= coincount - LEMONWATER_COST;
                    coincount <= 5'd0;
                    next_state <= IDLE;
                end

                CANCEL: begin
                    give <= 1'b1;
                    change <= coincount;
                    coincount <= 5'd0;
                    next_state <= IDLE;
                end

                default: begin
                    next_state <= IDLE;
                end
            endcase
        end
    end
endmodule
