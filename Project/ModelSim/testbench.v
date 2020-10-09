`timescale 100ps/1ps

module tsetbench;
wire t_s, t_cout;
reg t_a, t_b, t_cin;

my_adder fa(t_a,t_b,t_cin,t_s,t_cout);

initial
begin
t_a = 0;
t_b = 0;
t_cin = 0;

#5
t_a = 1;

#5
t_b = 1;

#5
t_cin = 1;

end

endmodule
