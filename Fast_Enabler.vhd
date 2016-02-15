------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 4/3/0215
-- Lab # and name	: Lab8 - Techo Tugo War
-- Student 1		: JErett Johsntoen 
-- Student 2		: Qaleb Rush

-- Description		: Produces a slow enable for various purposes
--					  Utilizes code style that should not be used elsewhere in lab.

-- Changes 
-- 		1.0	- Original (64 Hz)

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------

-- Library Declarations 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity 
entity fast_enabler is
    Port ( clk : in  STD_LOGIC;
		   Sen: out STD_LOGIC
		  );
end fast_enabler;

-- Architecture 
-- DO NOT USE THESE IN YOUR CODE
architecture Behavioral of fast_enabler is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	-- NONE	
	
	-------------------------------------------------------
	-- Internal Signal Declarations	
	-------------------------------------------------------

signal cnt: std_logic_vector (17 downto 0);
signal s: STD_LOGIC;

begin
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- NONE

	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------

-- DO NOT USE THIS CODE STYLE IN YOUR CODE! I DO NOT WANT TO SEE PROCESS OR EVENT!

	process(clk)
		begin 
			if clk'event and clk = '1' then
				-- every 781.25k clocks
				if cnt = "101111101011110000" then
					s <= '1';
					cnt <="000000000000000000";
				else
					cnt <= cnt +1;
					s <= '0';
				end if;
			end if;
	end process;
	
	Sen <= s;
	
end Behavioral;

