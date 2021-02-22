module fourToOneMUX(out, s0, s1, in);
    output reg out;
    input s0, s1;
    input [3:0] in;
    always @(*) begin
            case ({s1,s0})
                2'b00:  out = in[0];
                2'b01:  out = in[1];
                2'b10:  out = in[2];
                2'b11:  out = in[3];
            endcase
        end
endmodule

module twoToOneMUX(out, c, s0, s1);
    output reg out;
    input c;
    input s0, s1;
    always @(*) begin
            case (c)
                1'b0:  out = s0;
                1'b1:  out = s1;
            endcase
        end
endmodule


module oneHotEncodedMUX (out, in, configure);
    input [3:0] configure;
    input [3:0] in;
    output out;
    assign out = (configure[0] & in[0]) | (configure[1] & in[1]) | (configure[2] & in[2]) | (configure[3] & in[3]);
endmodule

module switch_box_4x4(out, in);
    input [3:0] in;
    output [3:0] out;
    reg [15:0] configure;

    oneHotEncodedMUX p1(out[0], in, configure[3:0]);
    oneHotEncodedMUX p2(out[1], in, configure[7:4]);
    oneHotEncodedMUX p3(out[2], in, configure[11:8]);
    oneHotEncodedMUX p4(out[3], in, configure[15:12]);
endmodule

module logic_tile(out, clock, in1, in2, in3, in4, in5);
    input clock;
    output out;
    wire temp;
    reg temp2;
    input in1, in2, in3, in4, in5;
    reg [32:0] mem;
    wire [7:0] outTemp;
    reg qbar;
    wire f1, f2;
   

    fourToOneMUX o1 (.out(outTemp[0]), .s0(in1), .s1(in2), .in(mem[3:0]));
    fourToOneMUX o2 (.out(outTemp[1]), .s0(in1), .s1(in2), .in(mem[7:4]));
    fourToOneMUX o3 (.out(outTemp[2]), .s0(in1), .s1(in2), .in(mem[11:8]));
    fourToOneMUX o4 (.out(outTemp[3]), .s0(in1), .s1(in2), .in(mem[15:12]));
    fourToOneMUX o5 (.out(outTemp[4]), .s0(in1), .s1(in2), .in(mem[19:16]));
    fourToOneMUX o6 (.out(outTemp[5]), .s0(in1), .s1(in2), .in(mem[23:20]));
    fourToOneMUX o7 (.out(outTemp[6]), .s0(in1), .s1(in2), .in(mem[27:24]));
    fourToOneMUX o8 (.out(outTemp[7]), .s0(in1), .s1(in2), .in(mem[31:28]));
    fourToOneMUX o9 (.out(f1), .s0(in3), .s1(in4), .in(outTemp[3:0]));
    fourToOneMUX o10(.out(f2), .s0(in3), .s1(in4), .in(outTemp[7:4]));
    twoToOneMUX  o11(.out(temp), .c(in5), .s0(f1), .s1(f2));

    initial 
        begin
        temp2 = 1'b0;
    end
    always@(posedge clock) 

        begin
            temp2 <= temp; 
            qbar = !temp; 
        end

    twoToOneMUX o12(.out(out), .c(mem[32]), .s0(temp), .s1(temp2));

endmodule


module fpga(i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, out, clock);
    input i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11;
    input clock;
    output [7:0] out;
    wire a1, a2, a3, a5, a6, a7, a8, a9, a10, a11, a12, a13, a15, a16, a17, a18, a19, a20, a21, a22, a23, a25, a26, a27, a28, a29, a30,a31, a32;
    wire o1, o2, o3, o4, o5, o6, o7, o8;
    wire c1, c2, c3, c4, c5, c6, c7,c8;
    wire out1, out2, out3, out4, out5, out6, out7, out8;
    wire d1, d2, d3, d4, d5, d6;

    switch_box_4x4 s1(.in({i1, i2, i3, i4}), .out({a1, a2, a3, a4}));
    switch_box_4x4 s2(.in({i9, d3, i7, i8}), .out({a5, a6, a7, a8}));
    switch_box_4x4 s3(.in({i1, i2, i5, i6}), .out({a9, a10, a11, a12}));
    switch_box_4x4 s4(.in({i5, i6, i11, i10}), .out({a13, a14, a15, a16}));
    
    logic_tile l1(.out(d1), .clock(clock), .in5(a5), .in4(a14), .in3(a13), .in2(a2), .in1(a1));
    logic_tile l2(.out(d2),   .clock(clock), .in5(a5), .in4(a14), .in3(a13), .in2(a4), .in1(a3));
    logic_tile l3(.out(d3), .clock(clock), .in5(a5), .in4(a14), .in3(a13), .in2(a10), .in1(a9));
    
    switch_box_4x4 s5(.in({i7, i8, i10, i11}), .out({a17, a18, a19, a20}));
    switch_box_4x4 s6(.in({i3, i4, d1, d2}), .out({a21, a22, a23, a24}));
    switch_box_4x4 s7(.in({i7, i8, d3, d4}), .out({a25, a26, a27, a28}));
    switch_box_4x4 s8(.in({i3, i4, i7, i8}), .out({a29, a30, a31, a32}));
    
    logic_tile l4(.out(d4), .clock(clock), .in5(a6), .in4(a18), .in3(a17), .in2(a30), .in1(a29));
    logic_tile l5(.out(d5), .clock(clock), .in5(a6), .in4(a26), .in3(a25), .in2(a22), .in1(a21));
    logic_tile l6(.out(d6), .clock(clock), .in5(a6), .in4(a26), .in3(a25), .in2(a22), .in1(a21));  
    
    logic_tile l7 (.out(c8), .clock(clock), .in5(1'b0), .in4(a15), .in3(a16), .in2(o7), .in1(a5));
    logic_tile l8 (.out(o8), .clock(clock), .in5(a15), .in4(a16), .in3(a8), .in2(o8), .in1(c8));
    logic_tile l9 (.out(c7), .clock(clock), .in5(1'b0), .in4(a15), .in3(a16), .in2(o6), .in1(o8));
    logic_tile l10(.out(o7), .clock(clock), .in5(a15), .in4(a16), .in3(a7), .in2(o7), .in1(c7));
    logic_tile l11(.out(c6), .clock(clock), .in5(1'b0), .in4(a15), .in3(a16), .in2(o5), .in1(o7));
    logic_tile l12(.out(o6), .clock(clock), .in5(a15), .in4(a16), .in3(a14), .in2(o6), .in1(c6));
    logic_tile l13(.out(c5), .clock(clock), .in5(1'b0), .in4(a15), .in3(a16), .in2(o4), .in1(o6));
    logic_tile l14(.out(o5), .clock(clock), .in5(a15), .in4(a16), .in3(a13), .in2(o5), .in1(c5));
    logic_tile l15(.out(c4), .clock(clock), .in5(1'b0), .in4(a15), .in3(a16), .in2(o3), .in1(o5));
    logic_tile l16(.out(o4), .clock(clock), .in5(a15), .in4(a16), .in3(a4), .in2(o4), .in1(c4));
    logic_tile l17(.out(c3), .clock(clock), .in5(1'b0), .in4(a15), .in3(a16), .in2(o2), .in1(o4));
    logic_tile l18(.out(o3), .clock(clock), .in5(a15), .in4(a16), .in3(a3), .in2(o3), .in1(c3));
    logic_tile l19(.out(c2), .clock(clock), .in5(1'b0), .in4(a15), .in3(a16), .in2(o1), .in1(o3));
    logic_tile l20(.out(o2), .clock(clock), .in5(a15), .in4(a16), .in3(a2), .in2(o2), .in1(c2));
    logic_tile l21(.out(c1), .clock(clock), .in5(1'b0), .in4(a15), .in3(a16), .in2(1'b0), .in1(o2));
    logic_tile l22(.out(o1), .clock(clock), .in5(a15), .in4(a16), .in3(a1), .in2(o1), .in1(c1));

    switch_box_4x4 s9 (.in({o1, d1, o2, d2}), .out({out[0], out1, out[1] ,out2}));
    switch_box_4x4 s10(.in({o3, d3, o4, d4}), .out({out3, out3, out4 ,out4}));
    switch_box_4x4 s11(.in({o5, d5, o6, d6}), .out({out5, out5, out6 ,out6}));
    switch_box_4x4 s12(.in({out3, out4, out5, out6}), .out({out[2], out[3], out[4] ,out[5]}));
    switch_box_4x4 s13(.in({o7, o8, 1'b0, 1'b0}), .out({out[6], out[7], out7 ,out8}));   
endmodule

// iverilog FPGA.v tb_shifter.v && ./a.out
// iverilog FPGA.v tb_mux.v  && ./a.out
// iverilog FPGA.v tb_adder.v
// ./a.out