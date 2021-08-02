


library IEEE;
use IEEE.std_logic_1164.all;

entity vhdl_test is port (
	A: in std_logic;
	B: in std_logic;
	C: out std_logic
);
end vhdl_test;

architecture hardware of vhdl_test is 
begin
	C <= A and B;
end hardware;
