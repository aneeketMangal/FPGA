module testbench();
    reg i1, i2, i3, i4, i5, i6, i7, i8, c2, c3, c1;
    wire [7:0] out;
    reg [31:0] LUT [0:56];
 
    reg clk;
    initial clk = 0; 
    always #10 clk = ~clk;
    
    fpga mux(.i1(i1), .i2(i2), .i3(i3), .i4(i4), .i5(i5), .i6(i6), .i7(i7), .i8(i8), .i9(c3), .i10(c2), .i11(c1), .out(out), .clock(clk));

    initial
        begin
            
            $readmemh("configure_mux.mem", LUT);
            $dumpfile("cs203.vcd");
            $dumpvars;
            
            
            mux.s1.configure = LUT[0];
            mux.s2.configure = LUT[1];
            mux.s3.configure = LUT[2];
            mux.s4.configure = LUT[3];

            mux.l1.mem[31:0]=LUT[4];
            mux.l1.mem[32]=LUT[5][0];
            mux.l2.mem[31:0]=LUT[6];
            mux.l2.mem[32]=LUT[7][0];
            mux.l3.mem[31:0]=LUT[8];
            mux.l3.mem[32]=LUT[9][0];

            mux.s5.configure = LUT[10];
            mux.s6.configure = LUT[11];
            mux.s7.configure = LUT[12];
            mux.s8.configure = LUT[13];

            mux.l4.mem[31:0]=LUT[14];
            mux.l4.mem[32]=LUT[15][0];
            mux.l5.mem[31:0]=LUT[16];
            mux.l5.mem[32]=LUT[17][0];
            mux.l6.mem[31:0]=LUT[18];
            mux.l6.mem[32]=LUT[19][0];

            mux.l7.mem[31:0] = LUT[20];
            mux.l7.mem[32] = LUT[21][0];
            mux.l8.mem[31:0] = LUT[22];
            mux.l8.mem[32] = LUT[23][0];
            mux.l9.mem[31:0] = LUT[24];
            mux.l9.mem[32] = LUT[25][0];
            mux.l10.mem[31:0] = LUT[26];
            mux.l10.mem[32] = LUT[27][0];
            mux.l11.mem[31:0] = LUT[28];
            mux.l11.mem[32] = LUT[29][0];
            mux.l12.mem[31:0] = LUT[30];
            mux.l12.mem[32] = LUT[31][0];
            mux.l13.mem[31:0] = LUT[32];
            mux.l13.mem[32] = LUT[33][0];
            mux.l14.mem[31:0] = LUT[34];
            mux.l14.mem[32] = LUT[35][0];
            mux.l15.mem[31:0] = LUT[36];
            mux.l15.mem[32] = LUT[37][0];
            mux.l16.mem[31:0] = LUT[38];
            mux.l16.mem[32] = LUT[39][0];
            mux.l17.mem[31:0] = LUT[40];
            mux.l17.mem[32] = LUT[41][0];
            mux.l18.mem[31:0] = LUT[42];
            mux.l18.mem[32] = LUT[43][0];
            mux.l19.mem[31:0] = LUT[44];
            mux.l19.mem[32] = LUT[45][0];
            mux.l20.mem[31:0] = LUT[46];
            mux.l20.mem[32] = LUT[47][0];
            mux.l21.mem[31:0] = LUT[48];
            mux.l21.mem[32] = LUT[49][0];
            mux.l22.mem[31:0] = LUT[50];
            mux.l22.mem[32] = LUT[51][0];
             
            mux.s9.configure = LUT[52];
            mux.s10.configure = LUT[53];
            mux.s11.configure = LUT[54];
            mux.s12.configure = LUT[55];
            mux.s13.configure = LUT[56];

            i1 = 1'b1;
            i2 = 1'b1;
            i3 = 1'b1;
            i4 = 1'b1;
            i5 = 1'b1;
            i6 = 1'b1;
            i7 = 1'b1;
            i8 = 1'b0;  
            {i8, i7, i6, i5, i4, i3, i2, i1} = 8'b01101110;

            $display("VALUES       :- %b\n-----------------------------", {i8, i7, i6, i5, i4, i3, i2, i1});

            {c3, c2, c1} = 3'b111;
            #10
            $display("Control Bits :- %b", {c3, c2, c1});
            $display("Output       :- %b\n-----------------------------", out[4]);
            {c3, c2, c1} = 3'b110;
            #10
            $display("Control Bits :- %b", {c3, c2, c1});
            $display("Output       :- %b", out[4]);
            // c3 = 1'b0; c2 = 1'b0; c1 = 1'b1;
            // #10
            // $display("Control Bits :- %b", {c3, c2, c1});
            // $display("Output       :- %b\n", out[4]);

            // c3 = 1'b0; c2 = 1'b1; c1 = 1'b0;
            // #10
            // $display("Control Bits :- %b", {c3, c2, c1});
            // $display("Output       :- %b\n", out[4]);

            // c3 = 1'b0; c2 = 1'b1; c1 = 1'b1;
            // #10
            // $display("Control Bits :- %b", {c3, c2, c1});
            // $display("Output       :- %b\n", out[4]);

            // c3 = 1'b1; c2 = 1'b0; c1 = 1'b0;
            // #10
            // $display("Control Bits :- %b", {c3, c2, c1});
            // $display("Output       :- %b\n", out[4]);

            // c3 = 1'b1; c2 = 1'b0; c1 = 1'b1;
            // #10
            // $display("Control Bits :- %b", {c3, c2, c1});
            // $display("Output       :- %b\n", out[4]);

            // c3 = 1'b1; c2 = 1'b1; c1 = 1'b0;
            // #10
            // $display("Control Bits :- %b", {c3, c2, c1});
            // $display("Output       :- %b\n", out[4]);

            // c3 = 1'b1; c2 = 1'b1; c1 = 1'b1;
            // #10
            // $display("Control Bits :- %b", {c3, c2, c1});
            // $display("Output       :- %b\n", out[4]);
    
            $finish;
        end
endmodule