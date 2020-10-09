﻿module Registers(
input clk, rst,
input RegDst, RegWrite,
input [4:0] Reg1, Reg2, AddrWriteRegister,
input wire [31:0] WriteDataToRegister,
output reg [31:0] Data1, Data2
);

reg [31:0] regs [0:31]; // 32비트 레지스터 32개
reg [31:0] temp1, temp2;

always @(*) begin // 레지스터의 값을 읽기
if (RegDst== 1 && RegWrite==1) begin // R Type
	Data1 = regs[Reg1];
	Data2 = regs[Reg2];
	end
else
if (RegDst== 0 && RegWrite==1) begin // I Type
	Data1 = regs[Reg1];
	Data2 = regs[Reg2];
	end
end

// 레지스터에 값을 쓰기
always @(negedge clk) begin 
if (!rst) begin // 레지스터 초기화
	regs[0] = 32'd0;
	regs[1] = 32'd0;
	regs[2] = 32'd0;
	regs[3] = 32'd0;
	regs[4] = 32'd0;
	regs[5] = 32'd0;
	regs[6] = 32'd0;
	regs[7] = 32'd0;
	regs[8] = 32'd0;
	regs[9] = 32'd0;
	regs[10] = 32'd0;
	regs[11] = 32'd0;
	regs[12] = 32'd0;
	regs[13] = 32'd0;
	regs[14] = 32'd0;
	regs[15] = 32'd0;
	regs[16] = 32'd0; 
	regs[17] = 32'd0;
	regs[18] = 32'd0;
	regs[19] = 32'd0;
	regs[20] = 32'd0;
	regs[21] = 32'd0; 
	regs[22] = 32'd0;
	regs[23] = 32'd0;
	regs[24] = 32'd0;
	regs[25] = 32'd0;
	regs[26] = 32'd0;
	regs[27] = 32'd0;
	regs[28] = 32'd0;
	regs[29] = 32'd0;
	regs[30] = 32'd0;
	regs[31] = 32'd0;
end
else
	begin // 레지스터에 데이터 쓰기
	if (RegDst== 1 && RegWrite==1) begin // R Type
		regs[AddrWriteRegister] = WriteDataToRegister;
		end
	else
	if (RegDst== 0 && RegWrite==1) begin // I Type
		regs[AddrWriteRegister] = WriteDataToRegister;
		end
	end
end

endmodule

