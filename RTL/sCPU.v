module sCPU(
    input clk,
    input reset,
    output reg[7:0] gpr[3:0],
    output reg[6:0]led1,
    output [4:0] dbg_pc,
    output reg[6:0]led2
);
reg [4:0]PC;
wire [1:0]opcode;
wire [1:0]rd;
wire [1:0]rs1;
wire [1:0]rs2;
wire [3:0]imm;
wire [3:0]addr;
reg [7:0]rom;
assign rd=rom[5:4];
assign opcode=rom[7:6];
assign imm=rom[3:0];
assign rs1=rom[3:2];
assign rs2=rom[1:0];
assign addr=rom[5:2];


always @(*)begin
    case(PC)
    5'd0:rom=8'b10001011;     
    5'd1:rom=8'b10010001;  
    5'd2:rom=8'b10100000; 
    5'd3:rom=8'b10110001; 
    5'd4:rom=8'b00101001; 
    5'd5:rom=8'b00010111; 
    5'd6:rom=8'b11010001; 
    5'd7:rom=8'b01100000; 
    5'd8:rom=8'b11100010; 
     default:rom=8'b11100010;
    endcase
end

always @(posedge clk)begin
    if(reset)begin
        PC<=0;
        gpr[0]<=0;
        gpr[1]<=0;
        gpr[2]<=0;
        gpr[3]<=0;
        led1<=7'b1111111;
        led2<=7'b1111111;
    end
    else if(opcode==2'b00)begin
        gpr[rd]<=gpr[rs1]+gpr[rs2];
        PC<=PC+1;
    end
    else if(opcode==2'b10)begin
        gpr[rd]<={4'b0000,imm};
        PC<=PC+1;
    end
    else if(opcode==2'b11)begin
        if(gpr[rd]!=gpr[rs1])
        PC<={1'b0,addr};
        else
        PC<=PC+1;
    end
    else if(opcode==2'b01)begin
        case(gpr[rd][3:0])
         4'h0: led1<=7'b1000000; 
                4'h1: led1<=7'b1111001; 
                4'h2: led1<=7'b0100100; 
                4'h3: led1<=7'b0110000; 
                4'h4: led1<=7'b0011001;
                4'h5: led1<=7'b0010010; 
                4'h6: led1<=7'b0000010; 
                4'h7: led1<=7'b1111000;
                4'h8: led1<=7'b0000000;
                4'h9: led1<=7'b0010000;
                4'ha: led1<=7'b0001000;
                4'hb: led1<=7'b0000011;
                4'hc: led1<=7'b1000110;
                4'hd: led1<=7'b0100001;
                4'he: led1<=7'b0000110;
                4'hf: led1<=7'b0001110;
                default: led1<=7'b1111111;
            endcase
             case (gpr[rd][7:4])
                4'h0: led2<=7'b1000000; 
                4'h1: led2<=7'b1111001; 
                4'h2: led2<=7'b0100100; 
                4'h3: led2<=7'b0110000; 
                4'h4: led2<=7'b0011001;
                4'h5: led2<=7'b0010010; 
                4'h6: led2<=7'b0000010; 
                4'h7: led2<=7'b1111000;
                4'h8: led2<=7'b0000000;
                4'h9: led2<=7'b0010000;
                4'ha: led2<=7'b0001000;
                4'hb: led2<=7'b0000011;
                4'hc: led2<=7'b1000110;
                4'hd: led2<=7'b0100001;
                4'he: led2<=7'b0000110;
                4'hf: led2<=7'b0001110;
                default: led2<=7'b1111111;
            endcase
            PC<=PC+1;
    end
end
assign dbg_pc=PC;
endmodule
