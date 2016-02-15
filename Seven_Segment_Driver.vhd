------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 7, 2015
-- Lab # and name	: Lab 8 - SCORE!
-- Student 1		: Qaleb Rush
-- Student 3		: Jerett Johnstone

-- Description		: Driver to convert a 4-bit unsigned binary number to a seven segment led.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Seven_Segment_Driver is port
	( 
		B3		:	in		std_logic; -- Input bit - Most significant
		B2		:	in		std_logic; -- Input bit
		B1		:	in		std_logic; -- Input bit
		B0		:	in		std_logic; -- Input bit - Least significant
		
		CA		:	out	std_logic; -- Output cathode
		CB		:	out	std_logic; -- Output cathode
		CC		:	out	std_logic; -- Output cathode
		CD		:	out	std_logic; -- Output cathode
		CE		:	out	std_logic; -- Output cathode
		CF		:	out	std_logic; -- Output cathode
		CG		:	out	std_logic  -- Output cathode
	);
end Seven_Segment_Driver;
----------------------------------------------------------------------

-- Architecture 
architecture Seven_Segment_Driver_a of Seven_Segment_Driver is
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
	
	CA <= (NOT B3 AND NOT B2 AND NOT B1 AND B0) OR (NOT B3 AND B2 AND NOT B1 AND NOT B0) OR (B3 AND B2 AND NOT B1 AND B0) OR (B3 AND NOT B2 AND B1 AND B0);
	CB <= (B3 AND B2 AND NOT B0) OR (B3 AND B1 AND B0) OR (B2 AND B1 AND NOT B0) OR (NOT B3 AND B2 AND NOT B1 AND B0);
	CC <= (B3 OR B1) AND (B1 OR NOT B0) AND (B3 OR NOT B0) AND (B3 OR NOT B2) AND (NOT B3 OR B2);
	CD <= (NOT B2 AND NOT B1 AND B0) OR (NOT B3 AND B2 AND NOT B1 AND NOT B0) OR (B2 AND B1 AND B0) OR (B3 AND NOT B2 AND B1 AND NOT B0);
	CE <= (NOT B3 AND B0) OR (NOT B3 AND B2 AND NOT B1) OR (NOT B2 AND NOT B1 AND B0);
	CF <= (NOT B3 AND NOT B2 AND B0) OR (NOT B3 AND NOT B2 AND B1) OR (NOT B3 AND B2 AND B1 AND B0) OR (B3 AND B2 AND NOT B1 AND B0);
	CG <= (NOT B3 AND NOT B2 AND NOT B1) OR (NOT B3 AND B2 AND B1 AND B0) OR (B3 AND B2 AND NOT B1 AND NOT B0);
 			 
end Seven_Segment_Driver_a; -- .same name as the architecture