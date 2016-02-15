------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Fianl Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: 3-Bit Decoder. Takes in 3 select bits and outputs 8 bits. 1 output will be a 1 depending on the 
--						  select bits. The rest will be 0's.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Three_Bit_Decoder is port
	( 
		S2			:	in		std_logic; -- First select bit
		S1			:	in		std_logic; -- Second select bit
		S0			:	in		std_logic; -- Third select bit
		
		D7			:	out	std_logic; -- First output bit
		D6			:	out	std_logic; -- Second output bit
		D5			:	out	std_logic; -- Third output bit
		D4			:	out	std_logic; -- Fourth output bit
		D3			:	out	std_logic; -- Fifth output bit
		D2			:	out	std_logic; -- Sixth output bit
		D1			:	out	std_logic; -- Seventh output bit
		D0			:	out	std_logic  -- Eigth output bit
	);
end Three_Bit_Decoder;
----------------------------------------------------------------------

-- Architecture 
architecture Three_Bit_Decoder_a of Three_Bit_Decoder is
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
	
	D7 <= S2 AND S1 AND S0;
	D6 <= S2 AND S1 AND NOT S0;
	D5 <= S2 AND NOT S1 AND S0;
	D4 <= S2 AND NOT S1 AND NOT S0;
	D3 <= NOT S2 AND S1 AND S0;
	D2 <= NOT S2 AND S1 AND NOT S0;
	D1 <= NOT S2 AND NOT S1 AND S0;
	D0 <= NOT S2 AND NOT S1 AND NOT S0;
 			 
end Three_Bit_Decoder_a; -- .same name as the architecture