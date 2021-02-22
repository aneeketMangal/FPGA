module testbench();
    reg i1, i2, i3, i4, i5, i6, i7, i8, sIn, c1, c2;
    wire [7:0] out;
    reg [31:0] LUT [0:56];
 
    reg clk;
    initial clk = 0; 
    always #10 clk = ~clk;
    
    fpga ShiftRegister(.i1(i1), .i2(i2), .i3(i3), .i4(i4), .i5(i5), .i6(i6), .i7(i7), .i8(i8), .i9(sIn), .i10(c1), .i11(c2), .out(out), .clock(clk));

    initial
        begin
            
            $readmemh("configure_shifter.mem", LUT);
            $dumpfile("cs203.vcd");
            $dumpvars;
            ShiftRegister.s1.configure = LUT[0];
            ShiftRegister.s2.configure = LUT[1];
            ShiftRegister.s3.configure = LUT[2];
            ShiftRegister.s4.configure = LUT[3];

            ShiftRegister.l1.mem[31:0]=LUT[4];
            ShiftRegister.l1.mem[32]=LUT[5][0];
            ShiftRegister.l2.mem[31:0]=LUT[6];
            ShiftRegister.l2.mem[32]=LUT[7][0];
            ShiftRegister.l3.mem[31:0]=LUT[8];
            ShiftRegister.l3.mem[32]=LUT[9][0];

            ShiftRegister.s5.configure = LUT[10];
            ShiftRegister.s6.configure = LUT[11];
            ShiftRegister.s7.configure = LUT[12];
            ShiftRegister.s8.configure = LUT[13];

            ShiftRegister.l4.mem[31:0]=LUT[14];
            ShiftRegister.l4.mem[32]=LUT[15][0];
            ShiftRegister.l5.mem[31:0]=LUT[16];
            ShiftRegister.l5.mem[32]=LUT[17][0];
            ShiftRegister.l6.mem[31:0]=LUT[18];
            ShiftRegister.l6.mem[32]=LUT[19][0];

            ShiftRegister.l7.mem[31:0] = LUT[20];
            ShiftRegister.l7.mem[32] = LUT[21][0];
            ShiftRegister.l8.mem[31:0] = LUT[22];
            ShiftRegister.l8.mem[32] = LUT[23][0];
            ShiftRegister.l9.mem[31:0] = LUT[24];
            ShiftRegister.l9.mem[32] = LUT[25][0];
            ShiftRegister.l10.mem[31:0] = LUT[26];
            ShiftRegister.l10.mem[32] = LUT[27][0];
            ShiftRegister.l11.mem[31:0] = LUT[28];
            ShiftRegister.l11.mem[32] = LUT[29][0];
            ShiftRegister.l12.mem[31:0] = LUT[30];
            ShiftRegister.l12.mem[32] = LUT[31][0];
            ShiftRegister.l13.mem[31:0] = LUT[32];
            ShiftRegister.l13.mem[32] = LUT[33][0];
            ShiftRegister.l14.mem[31:0] = LUT[34];
            ShiftRegister.l14.mem[32] = LUT[35][0];
            ShiftRegister.l15.mem[31:0] = LUT[36];
            ShiftRegister.l15.mem[32] = LUT[37][0];
            ShiftRegister.l16.mem[31:0] = LUT[38];
            ShiftRegister.l16.mem[32] = LUT[39][0];
            ShiftRegister.l17.mem[31:0] = LUT[40];
            ShiftRegister.l17.mem[32] = LUT[41][0];
            ShiftRegister.l18.mem[31:0] = LUT[42];
            ShiftRegister.l18.mem[32] = LUT[43][0];
            ShiftRegister.l19.mem[31:0] = LUT[44];
            ShiftRegister.l19.mem[32] = LUT[45][0];
            ShiftRegister.l20.mem[31:0] = LUT[46];
            ShiftRegister.l20.mem[32] = LUT[47][0];
            ShiftRegister.l21.mem[31:0] = LUT[48];
            ShiftRegister.l21.mem[32] = LUT[49][0];
            ShiftRegister.l22.mem[31:0] = LUT[50];
            ShiftRegister.l22.mem[32] = LUT[51][0];
             
            ShiftRegister.s9.configure = LUT[52];
            ShiftRegister.s10.configure = LUT[53];
            ShiftRegister.s11.configure = LUT[54];
            ShiftRegister.s12.configure = LUT[55];
            ShiftRegister.s13.configure = LUT[56];
            
            /*
            sIn    c2       c1
            0       0       0   -->   right Shift/0 serial input
            0       0       1   -->   left shift
            0       1       0   -->   Retain
            0       1       1   -->   parallel input
            1       0       0   -->   serial input(1)
            */
           {i8, i7, i6, i5, i4, i3, i2, i1} = 8'b10111001;
            
            {sIn, c2, c1} = 3'b011;
            #11
            $display("Parallel Input   :- %b [%d]",out[7:0], out[7:0]);

            {sIn, c2, c1} = 3'b000;
            #20
            $display("After Right Shift:- %b [%d]",out[7:0], out[7:0]);
            // {sIn, c2, c1} = 3'b000;
            // #20
            // $display("After Right Shift:- %b [%d]",out[7:0], out[7:0]);

            {sIn, c2, c1} = 3'b001;
            #20

            $display("After Left Shift :- %b [%d]",out[7:0], out[7:0]);

            // {sIn, c2, c1} = 3'b000;
            // #20
            
            // $display("Another Right Shift :- %b",out[7:0]);
            {sIn, c2, c1} = 3'b010;
            #20
            $display("Retain           :- %b [%d]",out[7:0], out[7:0]);
            

            $display("Serial Input [11011100]:- ");
            {sIn, c2, c1} = 3'b000;
            #20
            $display("\t%b",out[7:0]);
            {sIn, c2, c1} = 3'b000;
            #20
            $display("\t%b",out[7:0]);
            {sIn, c2, c1} = 3'b100;
            #20
            $display("\t%b",out[7:0]);
            {sIn, c2, c1} = 3'b100;
            #20
            $display("\t%b",out[7:0]);
            {sIn, c2, c1} = 3'b100;
            #20
            $display("\t%b",out[7:0]);
            {sIn, c2, c1} = 3'b000;
            #20
            $display("\t%b",out[7:0]);
            {sIn, c2, c1} = 3'b100;
            #20
            $display("\t%b",out[7:0]);
            {sIn, c2, c1} = 3'b100;
            #20
            $display("\t%b",out[7:0]);

            {i8, i7, i6, i5, i4, i3, i2, i1} = 8'b11010011;
            {sIn, c2, c1} = 3'b011;
            #20
            $display("Another Parallel Input   :- %b",out[7:0]);


            $finish;
        end
endmodule



