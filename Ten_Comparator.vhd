------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 7, 2015
-- Lab # and name	: Lab 8 - SCOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
-- Student 1		: Qaleb Rush
-- Student 3		: Jerett Johnstone

-- Description		: 


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Ten_Comparator is port
	( 
		B3			:	in		std_logic; -- First input bit
		B2			:	in		std_logic; -- Second input bit
		B1			:	in		std_logic; -- Third input bit
		B0			:	in		std_logic; -- Fourth input bit
		
		output	:	out	std_logic  -- Output - Equal to 10
	);
end Ten_Comparator;
----------------------------------------------------------------------

-- Architecture 
architecture Ten_Comparator_a of Ten_Comparator is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	-- NONE
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	-- NONE

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- NONE
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	output <= B3 AND NOT B2 AND B1 AND NOT B0;
 			 
end Ten_Comparator_a; -- .same name as the architecture