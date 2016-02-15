------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Fianl Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: 4:1 MUX.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER 

-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Four_to_One_MUX is port
	( 
		A			: in 	std_logic; -- first bit input
		B			: in 	std_logic; -- second bit input
		C			: in 	std_logic; -- third bit input
		D			: in 	std_logic; -- fourth bit input
		
		S1			: in 	std_logic; -- first select input
		S0			: in 	std_logic; -- second select input
		
		M			: out std_logic  -- output bit 	
	);
end Four_to_One_MUX;
----------------------------------------------------------------------

-- Architecture 
architecture Four_to_One_MUX_a of Four_to_One_MUX is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------
	
	-- 2 to 1 Mux 
	component Multiplexer is port
		( 
			A			:	in		std_logic; -- First input -- Chosen when S is 1
			B			:	in		std_logic; -- Second input -- Chosen when S is 0
			S			:	in		std_logic; -- Select input
			
			M			:	out	std_logic  -- Output
		);
	end component;
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal M1		:	std_logic;	-- First MUX output
	signal M2		:	std_logic;	-- Second MUX output

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	MUX1 : Multiplexer port map
		(
			A => A,
			B => B,
			S => S0,
			
			M => M1
		);
		
	MUX0 : Multiplexer port map
		(
			A => C,
			B => D,
			S => S0,
			
			M => M2
		);
		
	RESULT : Multiplexer port map
		(
			A => M1,
			B => M2,
			S => S1,
			
			M => M
		);
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	-- NONE
 			 
end Four_to_One_MUX_a; -- .same name as the architecture