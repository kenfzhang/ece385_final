module falling(input t, input logic [9:0] v, output logic [9:0] final_height);

    logic [9:0] a, b;

    // V_init * time
    assign a = v * t;
    // -(1/2) * G * (t^2)
    assign b = 0.5 * 10 * t * t;

    assign final_height = a - b;

endmodule