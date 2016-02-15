------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: March 3, 2015
-- Lab # and name	: Lab 5 - How I learned to stop worrying and love the DFF
-- Student 3		: Jerett Johnstone
-- Student 2		: Caleb Rush

-- Description		: Clock controlled D-Latch using an SR-Latch


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity D_latch is port
	( 
		d			:	in std_logic	; -- The single input to set/reset the value of the latch
		clock		:	in std_logic	; -- The clock/controlling input that states when to copy the value of d
		
		output	:	out std_logic	  -- The output of the latch
	);
end D_latch;
----------------------------------------------------------------------

-- Architecture 
architecture D_latch_a of D_latch is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	component low_SR_latch is port
		( 
			set		: in std_logic		; 	-- input to set output to 1  		
			reset		: in std_logic		; 	-- input to set output to 0
		
			output	: out std_logic		-- active low SR latch output 
		);
	end component;
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal set		: std_logic; -- set signal to be calculated and input to SR latch
	signal reset	: std_logic; -- reset signal to be calculated and input to SR latch

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	latch : low_SR_latch port map
		(
			set		=>	set,
			reset		=>	reset,
			
			output	=>	output
		);
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	set <= NOT (d AND clock);
	reset <= NOT (NOT d AND clock);
 			 
end D_latch_a; -- .same name as the architecture