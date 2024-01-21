module booth_multiplier(
    input wire signed [3:0] multiplier, 
    input wire signed [3:0] multiplicand,
    input wire CLK,     // Global Clock
    input wire TCLK,    // Transmit Clock
    input wire rst,
    output reg tx,
    output wire signed [7:0] product);

    reg signed [3:0] acc;
	reg signed [3:0] Q;
    reg signed [3:0] Q_temp;
	reg q_minus;
    reg q_minus_temp;

    // serial transfer variable:
    integer selector;


    integer i;
    always @(posedge CLK or posedge rst)
    
    begin
        if (rst)
        begin
            acc = 0;
            Q = 0;
            q_minus = 0;
        end

        else
        begin
            Q = multiplier;
            for (i = 0; i < 4; i = i + 1)
            begin
                q_minus_temp = q_minus;
                Q_temp = Q;

                q_minus = Q[0];
                Q = Q>>1;

                if(Q_temp[0] != q_minus_temp)
                begin
                    if (Q_temp[0] == 0)
                    begin
                        acc = acc + multiplicand;
                    end

                    else
                    begin
                        acc = acc - multiplicand;
                    end
                end

                Q[3] = acc[0];
                acc = acc>>>1;
            end
        end
    end

    always @(posedge TCLK) begin

        if(selector == 0)
            tx = 1'b0;
        else if (selector == 9)
            tx = 1'b1;
        else if(selector == 10)
            tx = 1'b1;
        else
            tx = product[selector - 1];

        if(selector < 10) 
            selector = selector + 1;
        else
            selector = 0;
    end

    assign product[7:4] = acc;
    assign product[3:0] = Q;
endmodule
