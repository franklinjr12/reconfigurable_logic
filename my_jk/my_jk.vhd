library ieee;
use ieee.std_logic_1164.all;

entity my_jk is port (
	j,k,clk: IN std_logic;
	q: OUT std_logic);
end my_jk;

architecture jk of my_jk is 	
begin
	process (clk)
		variable aux: std_logic;
	begin
		if (clk'event and clk='1') then 
			if (j='0' and k='0') then 
				q <= aux;		
			elsif (j='1' and k='0') then
				aux := '1';
			elsif (j='0' and k='1') then	
				aux := '0';
			else 
				aux := not aux;
			end if;
		end if;
		q <= aux;
	end process;
end jk;