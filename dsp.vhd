
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dsp is
	port(
		output : out std_logic := '0'
	);
end dsp;

architecture bh of dsp is
component top is
port(
	clk: in std_logic
);
end component top;
	signal clk        : std_logic;
	signal divided    : std_logic := '0';
	signal counter    : integer := 0;
	type lut is array ( 0 to 13) of integer;
	constant my_lut   : lut := (
		0 => 1,
		1 => 2,
		2 => 3,
		3 => 4,
		4 => 5,
		5 => 6,
		6 => 7,
		7 => 8,
		8 => 7,
		9 => 6,
		10 => 5,
		11 => 4,
		12 => 3,
		13 => 2
	);
	signal input_data : integer := 0;
begin
--component map
u0: top port map (clk);

	clock: process
	begin
		clk <= '0';
		wait for 1 ps;
		
		clk <= '1';
		wait for 1 ps;
	end process;

	p_counter_data : process(clk)
	begin
		if(rising_edge(clk)) then
			divided    <= not divided;
			output     <= divided;
			counter    <= counter + 1;
			input_data <= my_lut(counter);
			
			if(counter = 13) then
				counter <= 0;
			end if;

		end if;	end process;

end bh;