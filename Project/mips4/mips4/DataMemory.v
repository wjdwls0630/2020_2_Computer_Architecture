﻿module DataMemory(
input clk, rst,
input wire MemWrite, MemRead,
input wire [6:0] Address,
input wire [31:0] WriteData,
output wire [31:0] ReadDataFromMemory
);

reg [31:0] mem [0:15];
reg [31:0] temp;

assign ReadDataFromMemory = temp;

always @(*) begin // Memory 읽기 동작은 조합회로로 처리됩니다
if (MemWrite == 0 && MemRead == 1)
	temp = mem[Address];
end

always @(negedge clk) begin // negedge 일때 데이터를 씁니다
if (!rst) // reset시 데이터 초기화
	begin
	mem[0] <= 32'd0; // data
	mem[1] <= 32'd0;
	mem[2] <= 32'd0;
	mem[3] <= 32'd0;
	mem[4] <= 32'd0;
	mem[5] <= 32'd1;
	mem[6] <= 32'd2;
	mem[7] <= 32'd3;
	mem[8] <= 32'd4;
	mem[9] <= 32'd5;
	mem[10] <= 32'd0;
	mem[11] <= 32'd0;
	mem[12] <= 32'd0;
	mem[13] <= 32'd0;
	mem[14] <= 32'd0;
	mem[15] <= 32'd0;	
	end
else
if (MemWrite == 1 && MemRead == 0) // Store Word
	mem[Address] <= WriteData;
end
endmodule
