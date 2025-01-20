module vending_mach_tb;

    // Inputs
    reg clk;
    reg reset;
    reg Fiverupee;
    reg Tenrupee;
    reg Waterbottle;
    reg cancel;
    reg [4:0] Waterbottle_added;

    // Outputs
    wire [4:0] Waterbottle_available;
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
        .Lemonwater(1'b0),         // Unused inputs set to 0
        .Sodabottle(1'b0),         // Unused inputs set to 0
        .Waterbottle(Waterbottle),
        .cancel(cancel),
        .Lemonwater_added(5'b0),   // No Lemonwater added
        .Sodabottle_added(5'b0),   // No Sodabottle added
        .Waterbottle_added(Waterbottle_added),
        .Lemonwater_available(),   // Unused outputs left unconnected
        .Sodabottle_available(),   // Unused outputs left unconnected
        .Waterbottle_available(Waterbottle_available),
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
        Waterbottle = 0;
        cancel = 0;
        Waterbottle_added = 5'd5; // 5 Waterbottles available

        $dumpfile("vending.vcd");
        $dumpvars(0, vending_mach_tb);

        // Reset the system
        #10 reset = 0;

        // Test Case 1: Purchase a Waterbottle with sufficient coins
        #20 Waterbottle = 1;               // Select Waterbottle
        #10 Waterbottle = 0;               // Deassert selection
        //#10 Fiverupee = 1; #10 Fiverupee = 0; // Insert 5 Rs
        #30 Tenrupee = 1; #10 Tenrupee = 0;   // Insert 10 Rs
        #30 Fiverupee = 1; #10 Fiverupee = 0;     

        // End simulation
        #70 $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | Reset=%b | Waterbottle=%b | Coincount=%0d | Product=%b | Change=%0d | Give=%b", 
                 $time, reset, Waterbottle, coincount, product, change, give);
    end

endmodule
