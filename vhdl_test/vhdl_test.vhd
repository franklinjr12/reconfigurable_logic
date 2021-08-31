


library IEEE;
use IEEE.std_logic_1164.all;

entity vhdl_test is port (
	A: in std_logic;
	B: in std_logic;
	clk: in std_logic;
	C: out std_logic
);


end vhdl_test;

architecture hardware of vhdl_test is 
	signal as: integer := 0;
	shared variable var: integer := 0;
begin
	C <= A and B;
	process (clk) 
	begin 
		if (clk'event and clk='1') then
			var := var+1;
			as <= as+1;
		end if;
	end process;	
end hardware;

