------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Final Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: Adds two 3-Bit numbers together and outputs the sum. This component does not account for overflow.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------
 
-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Three_Bit_Adder is port
	( 
		A2				:	in		std_logic; -- First number first bit
		A1				:	in		std_logic; -- First number second bit
		A0				:	in		std_logic; -- First number third bit
		
		B2				:	in		std_logic; -- Second number first bit
		B1				:	in		std_logic; -- Second number second bit
		B0				:	in		std_logic; -- Second number third bit
		
		S2				:	out	std_logic; -- First output bit
		S1				:	out	std_logic; -- First output bit
		S0				:	out	std_logic; -- First output bit
		CO				:	out	std_logic  -- Carry out bit
	);
end Three_Bit_Adder;
----------------------------------------------------------------------

-- Architecture 
architecture Three_Bit_Adder_a of Three_Bit_Adder is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	component Bit_Adder is port
		(
			B1		:	in		std_logic; -- First bit to add
			B2		:	in		std_logic; -- Second bit to add
			CI		:	in		std_logic; -- Carry in from a previous addition
			
			S		:	out	std_logic; -- Sum of the two bits
			CO		:	out	std_logic  -- Carry out of the sum
		);
	end component;
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal C2	:			std_logic; -- Second place carry signal
	signal C1	:			std_logic; -- First place carry signal

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- Bit adder to add the first bits together
	Add2 : Bit_Adder port map
		(
			B1 => A2,
			B2 => B2,
			CI => C2,
			 
			S	=> S2,
			CO => CO
		);
		
	-- Bit adder to add the second bits together
	Add1 : Bit_Adder port map
		(
			B1 => A1,
			B2 => B1,
			CI => C1,
			 
			S	=> S1,
			CO => C2
		);
		
	-- Bit adder to add the third bits together
	Add0 : Bit_Adder port map
		(
			B1 => A0,
			B2 => B0,
			CI => '0',
			 
			S	=> S0,
			CO => C1
		);
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	-- NONE
 			 
end Three_Bit_Adder_a; -- .same name as the architecture