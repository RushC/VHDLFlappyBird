------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: March 24, 2015
-- Lab # and name	: Tug of War 
-- Student 3		: Jerett Johnstone 
-- Student 2		: Caleb Rush

-- Description		: Bit Adder


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Bit_Adder is port
	(
		B1		:	in		std_logic; -- First bit to add
		B2		:	in		std_logic; -- Second bit to add
		CI		:	in		std_logic; -- Carry in from a previous addition
		
		S		:	out	std_logic; -- Sum of the two bits
		CO		:	out	std_logic  -- Carry out of the sum
	);
end Bit_Adder;

-- Architecture 
architecture Bit_Adder_a of Bit_Adder is
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
	
	S <= B1 XOR B2 XOR CI;
	CO <= (B1 AND B2) OR (B2 AND CI) OR (B1 AND CI);
 			 
end Bit_Adder_a; -- .same name as the architecture