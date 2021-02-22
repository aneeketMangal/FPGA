module testbench();
    reg a1, a2, a3, a4, b1, b2, b3, b4, cin, i10, i11;
    wire [7:0] out;
    reg [31:0] LUT [0:56];
 
    reg clk;
    initial clk = 0; 
    always #10 clk = ~clk;
    
    fpga adder(.i1(a1), .i2(a2), .i3(a3), .i4(a4), .i5(b1), .i6(b2), .i7(b3), .i8(b4), .i9(cin), .i10(1'b0), .i11(1'b0), .out(out), .clock(clk));

    initial
        begin
            
            $readmemh("configure_adder.mem", LUT);
            $dumpfile("cs203.vcd");
      $dumpvars;
            
            
            adder.s1.configure = LUT[0];
            adder.s2.configure = LUT[1];
            adder.s3.configure = LUT[2];
            adder.s4.configure = LUT[3];

            adder.l1.mem[31:0]=LUT[4];
            adder.l1.mem[32]=LUT[5][0];
            adder.l2.mem[31:0]=LUT[6];
            adder.l2.mem[32]=LUT[7][0];
            adder.l3.mem[31:0]=LUT[8];
            adder.l3.mem[32]=LUT[9][0];

            adder.s5.configure = LUT[10];
            adder.s6.configure = LUT[11];
            adder.s7.configure = LUT[12];
            adder.s8.configure = LUT[13];

            adder.l4.mem[31:0]=LUT[14];
            adder.l4.mem[32]=LUT[15][0];
            adder.l5.mem[31:0]=LUT[16];
            adder.l5.mem[32]=LUT[17][0];
            adder.l6.mem[31:0]=LUT[18];
            adder.l6.mem[32]=LUT[19][0];

            adder.l7.mem[31:0] = LUT[20];
            adder.l7.mem[32] = LUT[21][0];
            adder.l8.mem[31:0] = LUT[22];
            adder.l8.mem[32] = LUT[23][0];
            adder.l9.mem[31:0] = LUT[24];
            adder.l9.mem[32] = LUT[25][0];
            adder.l10.mem[31:0] = LUT[26];
            adder.l10.mem[32] = LUT[27][0];
            adder.l11.mem[31:0] = LUT[28];
            adder.l11.mem[32] = LUT[29][0];
            adder.l12.mem[31:0] = LUT[30];
            adder.l12.mem[32] = LUT[31][0];
            adder.l13.mem[31:0] = LUT[32];
            adder.l13.mem[32] = LUT[33][0];
            adder.l14.mem[31:0] = LUT[34];
            adder.l14.mem[32] = LUT[35][0];
            adder.l15.mem[31:0] = LUT[36];
            adder.l15.mem[32] = LUT[37][0];
            adder.l16.mem[31:0] = LUT[38];
            adder.l16.mem[32] = LUT[39][0];
            adder.l17.mem[31:0] = LUT[40];
            adder.l17.mem[32] = LUT[41][0];
            adder.l18.mem[31:0] = LUT[42];
            adder.l18.mem[32] = LUT[43][0];
            adder.l19.mem[31:0] = LUT[44];
            adder.l19.mem[32] = LUT[45][0];
            adder.l20.mem[31:0] = LUT[46];
            adder.l20.mem[32] = LUT[47][0];
            adder.l21.mem[31:0] = LUT[48];
            adder.l21.mem[32] = LUT[49][0];
            adder.l22.mem[31:0] = LUT[50];
            adder.l22.mem[32] = LUT[51][0];
             
            adder.s9.configure = LUT[52];
            adder.s10.configure = LUT[53];
            adder.s11.configure = LUT[54];
            adder.s12.configure = LUT[55];
            adder.s13.configure = LUT[56];
            {a4, a3, a2, a1} = 4'b1010;
            {b4, b3, b2, b1} = 4'b0011;
            
            
            cin = 1'b1;
            #10
            $display("a  : -  %b [%d]",{a4, a3, a2, a1}, {a4, a3, a2, a1});
            $display("b  : -  %b [%d]",{b4, b3, b2, b1}, {b4, b3, b2, b1});
            $display("cin: -     %b [ %d]",cin, cin);

            $display("Sum: - %b [%d]\n------------------",out[4:0], out[4:0]);

           {a4, a3, a2, a1} = 4'b1001;
            {b4, b3, b2, b1} = 4'b1011;
            cin = 1'b0;
            #10
            $display("a  : -  %b [%d]",{a4, a3, a2, a1}, {a4, a3, a2, a1});
            $display("b  : -  %b [%d]",{b4, b3, b2, b1}, {b4, b3, b2, b1});
            $display("cin: -     %b [ %d]",cin, cin);
            $display("Sum: - %b [%d]",out[4:0], out[4:0]);
    
            $finish;
        end
endmodule