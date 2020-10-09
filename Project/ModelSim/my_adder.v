module my_adder(a,b,cin,s,cout);
input a,b,cin;
output s,cout;
wire s1,c1,c2;
half_adder ha1(a,b,s1,c1);
half_adder ha2(cin,s1,s,c2);
or(cout,c1,c2);
endmodule