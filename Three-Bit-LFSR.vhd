------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Final Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: LFSR to generate random 2-bit numebrs.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Two_Bit_LFSR is port
	( 
		en			:	in		std_logic; -- Enable input
		rst		:	in		std_logic; -- Reset input
		clk		:	in		std_logic; -- Clock input
		
		B1			:	out	std_logic; -- First output bit
		B0			:	out	std_logic  -- Second output bit
	);
end Two_Bit_LFSR;
----------------------------------------------------------------------

-- Architecture 
architecture Two_Bit_LFSR_a of Two_Bit_LFSR is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	component dff270 is port
		(
			clk 	: in std_logic ;
			clken	: in std_logic ;
			rst 	: in std_logic ;
			d 		: in std_logic ;
			q 		: out std_logic
		);
	end component;
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal D		:	std_logic; -- Randomized entering bit
	
	signal Q1	:	std_logic; -- First DFF output signal
	signal Q2	:	std_logic; -- Second DFF output signal
	signal Q3	:	std_logic; -- Third DFF output signal 

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	DFF1 : dff270 port map
		(
			clk 	 => clk,
			clken	 => en,
			rst 	 => rst,
			d 		 => D,
			q 		 => Q1
		);
		
	DFF2 : dff270 port map
		(
			clk 	 => clk,
			clken	 => en,
			rst 	 => rst,
			d 		 => Q1,
			q 		 => Q2
		);
	
	DFF3 : dff270 port map
		(
			clk 	 => clk,
			clken	 => en,
			rst 	 => rst,
			d 		 => Q2,
			q 		 => Q3
		);
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	D <= Q2 XNOR Q3;
	B1 <= Q1;
	B0 <= Q2;
 			 
end Two_Bit_LFSR_a; -- .same name as the architecture