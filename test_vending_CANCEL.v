module vending_mach_tb;

    // Inputs
    reg clk;
    reg reset;
    reg Fiverupee;
    reg Tenrupee;
    reg Lemonwater;
    reg cancel;
    reg [4:0] Lemonwater_added;

    // Outputs
    wire [4:0] Lemonwater_available;
    wire [4:0] coincount;
    wire [1:0] product;
    wire give;
    wire [4:0] change;

    // Instantiate the Unit Under Test (UUT)
    vending_mach uut (
        .clk(clk),
        .reset(reset),
        .Fiverupee(Fiverupee),
        .Tenrupee(Tenrupee),
        .Lemonwater(Lemonwater),
        .Sodabottle(1'b0),           // Unused inputs set to 0
        .Waterbottle(1'b0),          // Unused inputs set to 0
        .cancel(cancel),
        .Lemonwater_added(Lemonwater_added),
        .Sodabottle_added(5'b0),     // No Sodabottle added
        .Waterbottle_added(5'b0),    // No Waterbottle added
        .Lemonwater_available(Lemonwater_available),
        .Sodabottle_available(),     // Unused outputs left unconnected
        .Waterbottle_available(),    // Unused outputs left unconnected
        .coincount(coincount),
        .product(product),
        .give(give),
        .change(change)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 ns clock period

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        Fiverupee = 0;
        Tenrupee = 0;
        Lemonwater = 0;
        cancel = 0;
        Lemonwater_added = 5'd5; // 5 Lemon Waters available

        $dumpfile("vending.vcd");
        $dumpvars(0, vending_mach_tb);

        // Reset the system
        #10 reset = 0;

        

        // Test Case 2: Cancel operation for Lemon Water
        #20 Lemonwater = 1;                 // Select Lemon Water
        #10 Lemonwater = 0;                 // Deassert selection
        #30 Tenrupee = 1; #10 Tenrupee = 0; // Insert 10 Rs
        #30 Fiverupee = 1; #10 Fiverupee = 0; // Insert 5 Rs (partial amount)
        #30 cancel = 1;                     // Trigger cancel operation
        #10 cancel = 0;                     // Deassert cancel
        #50;                                // Wait to observe refund

        // End simulation
        #70 $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | Reset=%b | Lemonwater=%b | Coincount=%0d | Product=%b | Change=%0d | Give=%b | Cancel=%b", 
                 $time, reset, Lemonwater, coincount, product, change, give, cancel);
    end

endmodule
