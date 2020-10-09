 module MIPS(
input wire clk,
input wire rst,
input wire [7:0] mips_in,
output reg [31:0] mips_out
);

reg [31:0] PC;
wire [31:0] Instruction, ALUResult, ReadDataFromMemory;
wire [31:0] WriteDataToRegister;
wire [3:0] ALUop;
wire [31:0] ReadData1, ReadData2;
// Mux 제어신호
wire RegDst, RegWrite;
wire MemWrite, MemRead, ALUSrc, MemtoReg;
wire Zero, Branch, NotEqualBranch, Jump;
// Register
wire [4:0] AddrWriteRegister;
wire [31:0] ALUSource;

// RegDst Mux
assign AddrWriteRegister = RegDst ? Instruction[15:11] : Instruction[20:16]; //RegDst = 1이면 Instruction[15:11]에 쓰고 RegDst = 0이면 Instruction[20:16]에 쓴다

// ALUSrc Mux
//assign ALUSource = ALUSrc ? {16'b0,Instruction[15:0]} : ReadData2; // bit확장 전
assign ALUSource = ALUSrc ? ((Instruction[15]==1) ? {16'hFFFF, Instruction[15:0]} : {16'h0, Instruction[15:0]}) : ReadData2; // bit확장 후, {16'hFFFF, Instruction[15:0]} : 1111111111111111|1xxxxxxxxxxxxxxx, {16'h0, Instruction[15:0]} : 0000000000000000|0xxxxxxxxxxxxxxx

// MemtoReg Mux
assign WriteDataToRegister = MemtoReg ? ReadDataFromMemory : ALUResult;
// ((Instruction[15]==1) ? {16'hFFFF, Instruction[15:0]} : {16'h0, Instruction[15:0]})

// 명령어 메모리 모듈을 생성
InstructionMemory IM(PC, Instruction, mips_in);

// 컨트롤로직 모듈 생성
Control Ctl(Instruction[31:26], Instruction[5:0], 
ALUop, RegDst, RegWrite, MemRead, MemWrite, ALUSrc, MemtoReg, Branch, NotEqualBranch, Jump);

// 레지스터 모듈 생성
Registers Reg1(clk, rst, RegDst, RegWrite, 
Instruction[25:21], Instruction[20:16], AddrWriteRegister, 
WriteDataToRegister, ReadData1, ReadData2);

// ALU 모듈 생성
ALU ALU1(ALUop, ReadData1, ALUSource, ALUResult, Zero);

// 데이터 메모리 모듈 생성
DataMemory DM(clk, rst, MemWrite, MemRead, ALUResult[6:0], ReadData2, ReadDataFromMemory);

always @(posedge clk) begin
if (!rst)
	PC <= 0; // 리셋 신호시 Program Counter 0으로 초기화
else
	begin
	if(Zero==1 && Branch==1) // 같으면 분기 처리
		PC <= PC + 32'd1 + ((Instruction[15]==1) ? {16'hFFFF, Instruction[15:0]} : {16'h0, Instruction[15:0]}); 
	else if(Zero==0 && NotEqualBranch==1) // 다르면 분기 처리
		PC <= PC + 32'd1 + ((Instruction[15]==1) ? {16'hFFFF, Instruction[15:0]} : {16'h0, Instruction[15:0]}); 
	else if(Jump == 1) // 무조건 분기 처리
		PC <= {7'b0,Instruction[25:0]};
	else
		begin
		PC <= PC + 32'd1; // 모두 아니면 PC를 4 증가
		if(ALUop == 4'b1000)
			begin
			mips_out <= ALUResult;
			end
		end
	
	end

end
endmodule
