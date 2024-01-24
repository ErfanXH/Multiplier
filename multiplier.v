module booth_multiplier(
    input wire signed [3:0] multiplier, 
    input wire signed [3:0] multiplicand,
    input wire CLK,     // Global Clock
    output reg tx,
    output wire signed [7:0] product);

    reg signed [3:0] acc;
	reg signed [3:0] Q;
    reg signed [3:0] Q_temp;
	reg q_minus;
    reg q_minus_temp;

    // serial transfer variable:
    integer selector;

    initial begin
        selector = 0;
    end

    integer i;
    always @(multiplier or multiplicand) begin
        acc = 0;
        q_minus = 0;
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

    always @(posedge CLK) begin

        if(selector == 0) begin
            tx = 1'b0;
            selector = selector + 1;
        end
        else if (selector == 9) begin
            tx = 1'b1;
            selector = 0;
        end
        else begin
            tx = product[selector - 1];
            //$display("selector = %b product[%b] = %b tx = %b", selector, selector, product[selector], tx);
            selector = selector + 1;
        end
        
    end

    assign product[7:4] = acc;
    assign product[3:0] = Q;
endmodule
