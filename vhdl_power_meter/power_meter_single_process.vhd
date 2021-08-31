library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity power_meter is port (
	clear,clk: IN std_logic;	
	voltage_rms, current_rms, apparent_power: buffer integer;
	power_factor: buffer integer;
	real_power, reactive_power: buffer integer;
	theta: buffer integer;
	ready: OUT std_logic);
end power_meter;

architecture core of power_meter is 
	
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

	function mycos (constant x: integer) return integer;
	function mycos (constant x: integer) return integer is
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
	end function mycos;

    -- simulated values
    -- the interface would be with an pointer to a memory
    -- valid for fixed 1 kHz sampling frequency
	type t_int_array is ARRAY(31 downto 0) of
		 integer;
	constant voltage1 :
		 t_int_array := (0,66,123,162,179,171,138,86,22,-44,-105,-151,-176,-176,-151,-105,-44,22,86,138,171,179,162,123,66,0,-66,-123,-162,-179,-171,-138);
	constant current1 :
        -- t_int_array := (0,1,3,4,4,4,3,2,0,-1,-2,-4,-4,-4,-4,-2,-1,1,2,3,4,4,4,3,1,0,-1,-3,-4,-4,-4,-3); -- 0
        -- t_int_array := (-3,-1,0,1,3,4,4,4,3,2,0,-1,-2,-4,-4,-4,-4,-3,-1,0,2,3,4,4,4,3,1,0,-1,-3,-4,-4); -- -pi/4 == 45 deg
        t_int_array := (-5,-4,-3,-2,0,1,3,4,4,4,4,2,0,0,-2,-4,-4,-4,-4,-3,-1,0,2,3,4,5,4,3,2,0,-1,-3); -- -pi/2 == 90 deg
begin

	process (clk, clear) --calculate all
        variable t2: integer := 0;
        variable t1: integer := 0;
        variable v: integer := 0;
        variable voltage_counter: integer := 0;
        variable current_counter: integer := 0;
        variable temp: integer := 0;
        variable ex: std_logic := '0';
        variable aux: std_logic := '0';
    
    begin
		if (clk'event and clk='1') then
            ready <= '0';
            if (clear='1') then
                voltage_rms <= 0;
                current_rms <= 0;
                apparent_power <= 0;
                theta <= 0;
                power_factor <= 0;
                real_power <= 0;
                reactive_power <= 0;
                ready <= '0';
            else                            
                v := 0;
                for i in voltage1'range loop				
                    v := v+(voltage1(i)*voltage1(i));				
                end loop;
                voltage_rms <= mysqrt(v/voltage1'length);
                v := 0;
                for i in current1'range loop				
                    v := v+(current1(i)*current1(i));				
                end loop;
                current_rms <= mysqrt(v/current1'length);
                apparent_power <= voltage_rms * current_rms;
                voltage_counter := 0;
                ex := '0';
                aux := '0';		
                for i in voltage1'range loop
                    if (ex='0' and i<(voltage1'length-1)) then
                        temp := voltage1(i);				
                            if ((temp >= 0 and voltage1(i-1) < 0) or (temp <= 0 and voltage1(i-1) > 0)) then
                                if (aux='1') then								
                                    ex := '1';
                                    t2 := i;
                                else
                                    aux := '1';
                                    t1 := i;
                                end if;
                            end if;
                    end if;
                    voltage_counter := t2;---t1;
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
                                    t2 := i;
                                else                            
                                    aux := '1';
                                    t1 := i;
                                end if;
                            end if;
                    end if;
                    current_counter := t2;---t1;
                end loop;	
                theta <= (((((current_counter-voltage_counter)*100*(2**16/833))))*180)/(2**16); --need to change here if variable frequency is desirable
                power_factor <= mycos(theta); --scaled by 100	
                -- if (power_factor < 0) then
                --     power_factor <= -power_factor;
                -- end if;
                real_power <= (apparent_power * power_factor)/100;
                reactive_power <= (apparent_power - real_power);
                if (real_power > 0) then
                    ready <= '1';
                end if;
            end if;
        end if;
	end process;	
end core;	