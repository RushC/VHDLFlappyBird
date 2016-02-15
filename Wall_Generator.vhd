------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Final Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: Generate one of 4 preset walls based on the select input.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Wall_Generator is port
	( 
		R1			:	in		std_logic; -- First select bit
		R0			:	in		std_logic; -- Second select bit
		
		B7			:	out	std_logic; -- First output bit
		B6			:	out	std_logic; -- Second output bit
		B5			:	out	std_logic; -- Third output bit
		B4			:	out	std_logic; -- Fourth output bit
		B3			:	out	std_logic; -- Fifth output bit
		B2			:	out	std_logic; -- Sixth output bit
		B1			:	out	std_logic; -- Seventh output bit
		B0			:	out	std_logic  -- Eighth output bit
	);
end Wall_Generator;
----------------------------------------------------------------------

-- Architecture 
architecture Wall_Generator_a of Wall_Generator is
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
	
	B7 <= '1';
	B6 <= NOT (R1 AND R0);
	B5 <= NOT R1;
	B4 <= NOT (R1 OR R0);
	B3 <= R1 AND R0;
	B2 <= R1;
	B1 <= R1 OR R0;
	B0 <= '1';
 			 
end Wall_Generator_a; -- .same name as the architecture