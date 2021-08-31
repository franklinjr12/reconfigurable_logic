library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

-- entity power_meter is port (
-- 	clear,clk: IN std_logic;	
-- 	power_factor: buffer integer;
-- 	theta_out: buffer integer;
-- 	ready: OUT std_logic);
-- end power_meter;

entity power_meter is port (
	clear,clk: IN std_logic;	
	voltage_rms, current_rms, apparent_power: buffer integer;
	power_factor: buffer integer;
	real_power, reactive_power: out integer;
	theta_out: buffer integer;
	ready: OUT std_logic);
end power_meter;

architecture core of power_meter is 

	-- signal voltage_rms, current_rms, apparent_power: integer := 0;
	-- signal real_power, reactive_power: integer;
	
	signal b_voltage_rms: std_logic := '0';
	signal b_current_rms: std_logic := '0';
	signal b_apparent_power: std_logic := '0';

	signal a2: integer := 0;
	signal v2: integer := 0;

	function mysqrt (constant x: integer) return integer;
	function mysqrt (constant x: integer) return integer is
	variable y: integer := 1;	
	begin 
		if (y=0) then
			return 0;
		end if;
		for i in 1 to 10 loop
		if (y=0) then
			return 0;
		end if;
			y := (y+x/y)/2;
		end loop;
		return y;		
	end function mysqrt;

	function mysin (constant x: integer) return integer;
	function mysin (constant x: integer) return integer is
	begin
		if (x > 50) then 
			return 150-x;
		elsif (x > 0) then 
			return (-x*25)/100+100;
		elsif (x > -50) then
			return (x*25)/100+100;
		else
			return x+150;
		end if;
	end function mysin;
	
	type t_int_array is ARRAY(31 downto 0) of
		 integer;
	constant voltage1 :
		 t_int_array := (0,0,67,124,163,180,172,139,87,23,10,1,-151,-176,-176,-151,-105,-44,23,87,139,172,180,163,124,67,1,-66,-123,-162,-179,-171);
	constant current1 :
		 t_int_array := (0,0,1,3,4,4,4,3,2,0,-1,-2,-4,-4,-4,-4,-2,-1,0,2,3,4,4,4,3,1,0,-1,-3,-4,-4,-4);

begin

	process (clk) --calculate voltage rms
	variable v: integer := 0;
	begin
		if (clk'event and clk='1' and b_voltage_rms = '0') then
			b_voltage_rms <= '1';
			v := 0;
			for i in voltage1'range loop				
				v := v+(voltage1(i)*voltage1(i));				
			end loop;
			voltage_rms <= mysqrt(v/voltage1'length);
		end if;
	end process;

	process (clk) --calculate current rms
	variable v: integer := 0;
	begin
		if (clk'event and clk='1' and b_current_rms = '0') then
			b_current_rms <= '1';
			v := 0;
			for i in current1'range loop				
				v := v+(current1(i)*current1(i));				
			end loop;
			current_rms <= mysqrt(v/current1'length);
		end if;
	end process;	

	process (clk) --calculate apparent power	
	begin
		if (clk'event and clk='1' and b_voltage_rms = '1' and b_current_rms = '1' and b_apparent_power='0') then			
			b_apparent_power <= '1';
			apparent_power <= voltage_rms * current_rms;
		end if;
	end process;	

	process (clk) --calculate power factor	
	variable theta: integer := 0;
	variable voltage_counter: integer := 0;
	variable current_counter: integer := 0;
	variable temp: integer := 0;
	variable ex: std_logic := '0';
	variable aux: std_logic := '0';
	begin
		if (clk'event and clk='1' and b_apparent_power='1') then	
			voltage_counter := 0;
			ex := '0';
			aux := '0';		
			for i in voltage1'range loop
				if (ex='0' and i<(voltage1'length-1)) then
					temp := voltage1(i);				
						if ((temp >= 0 and voltage1(i-1) < 0) or (temp <= 0 and voltage1(i-1) > 0)) then
							if (aux='1') then								
								ex := '1';
								v2 <= i;
							else
								aux := '1';
							end if;
						end if;
					voltage_counter := voltage_counter + 1;
				end if;
				voltage_counter := v2;
			end loop;
			current_counter := 0;
			ex := '0';
			aux := '0';
			for i in current1'range loop
				if (ex='0' and i<(current1'length-1)) then									
					temp := current1(i);				
						if ((temp >= 0 and current1(i-1) < 0) or (temp <= 0 and current1(i-1) > 0)) then
							if (aux='1') then								
								ex := '1';
								a2 <= i;
							else
								aux := '1';
							end if;
						end if;
					current_counter := current_counter + 1;
				end if;
				current_counter := a2;
			end loop;	
			theta_out <= (((((current_counter-voltage_counter)*100*(2**16/833))))*180)/(2**16);
			power_factor <= mysin(theta_out); --scaled by 100			
			real_power <= (apparent_power * power_factor)/100;
			reactive_power <= (apparent_power * (100 - power_factor))/100;
			ready <= '1';
		end if;
	end process;	
	
end core;	