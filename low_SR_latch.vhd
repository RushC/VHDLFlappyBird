------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 3/3/2015
-- Lab # and name	: 5 FLIPPYFLOPPS
-- Student 1		: Caleb Rush
-- Student 3		: Jerett Johnstone 

-- Description		: active low SR latch


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity low_SR_latch is port
	( 
		set		: in std_logic		; 	-- input to set output to 1  		
		reset		: in std_logic		; 	-- input to set output to 0
		
		output	: out std_logic		-- active low SR latch output 
	);
end low_SR_latch;
----------------------------------------------------------------------

-- Architecture 
architecture low_SR_latch_a of low_SR_latch is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	-- NONE
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal q  : std_logic; -- output signal
	signal q0 : std_logic; -- not output signal

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- NONE
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	q0 <= NOT (reset AND q);
	q <= NOT (set AND q0);
	
	output <= q; 
 			 
end low_SR_latch_a; -- .same name as the architecture