module platform_sprite ( input [10:0] addr,
                        output [15:0] data);

    parameter ADDR_WIDTH = 11;
    parameter DATA_WIDTH = 15;
    logic [ADDR_WIDTH-1:0] addr_reg;

    // ROM definition
    parameter [0:2**ADDR_WIDTH-1][DATA_WIDTH-1:0] ROM = {
        // code 00
        16'b1111111111111111, //0****************
        16'b1000000000000000, //1*              
        16'b1000000000000000, //2*              
        16'b1111111111111111, //3****************
        // code 01
        16'b1111111111111111, //0****************
        16'b0000000000000000, //1              
        16'b0000000000000000, //2              
        16'b1111111111111111, //3****************
        // code 02
        16'b1111111111111111, //0****************
        16'b0000000000000001, //1               *
        16'b0000000000000001, //2               *
        16'b1111111111111111, //3****************
    }
    assign data = ROM[addr];
endmodule
