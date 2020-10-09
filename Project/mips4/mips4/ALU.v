﻿module ALU(
input [3:0] ALUop,
input [31:0] OpA, OpB,
output wire [31:0] ALUResult,
output Zero
);

/*
assign out = (ALUop == 4'b0010) ? a+b : a+b;
assign out = ((ALUop == 4'b0110) ? a-b : a-b);
assign out = ((ALUop == 4'b1000) ? a*b : 32'd0);

assign out = ALUop == 4'b0010 ? a+b : ((ALUop == 4'b0110) ? a-b : 
((ALUop == 4'b1000) ? a*b : 32'd0));

//assign out = a + b;
*/
reg [31:0] temp;
reg ZeroFlag;

assign ALUResult = temp;
assign Zero = ZeroFlag; // 빼서 0이면 둘은 같다

always @(*) begin
case (ALUop)
	4'b0010: begin
		temp = OpA + OpB;
		ZeroFlag = 0;
		end
	4'b0110: begin
		temp = OpA - OpB;
		if(temp == 0) // 두 입력 값이 같으면
			ZeroFlag = 1; //ZeroFlag에 1을 대입->PCSrc 입력 값
		else
			ZeroFlag = 0; //두 입력 값이 다르면 ZeroFlag에 0을 대입
		end
	4'b1000: begin
		temp = OpA * OpB;
		ZeroFlag = 0;
		end
	4'b0000: begin // AND
		temp = OpA & OpB; //bitwise AND
		ZeroFlag = 0;
		end
	4'b0001: begin // OR
		temp = OpA | OpB; //bitwise OR
		ZeroFlag = 0;
		end	
	4'b1101: begin // XOR
		temp = OpA ^ OpB; //bitwise XOR
		ZeroFlag = 0;
		end	
	4'b1100: begin // NOR
		temp = ~(OpA | OpB); //bitwise NOR
		ZeroFlag = 0;
		end
endcase
end
endmodule