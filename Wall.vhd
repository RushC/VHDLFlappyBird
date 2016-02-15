------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Final Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: Wall


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Wall is port
	( 
		clk		:	in 	std_logic; -- Clock input
		rst		:	in 	std_logic; -- Reset input
		en			:	in		std_logic; -- clock enable
		
		R2			:	in 	std_logic; -- First reset bit
		R1			:	in 	std_logic; -- Second reset bit
		R0			:	in 	std_logic; -- Third reset bit
		
		A7			:	out	std_logic; -- First Anode output
		A6			:	out	std_logic; -- Second Anode output
		A5			:	out	std_logic; -- Third Anode output
		A4			:	out	std_logic; -- Fourth Anode output
		A3			:	out	std_logic; -- Fifth Anode output
		A2			:	out	std_logic; -- Sixth Anode output
		A1			:	out	std_logic; -- Seventh Anode output
		A0			:	out	std_logic; -- Eighth Anode output
		
		C2			:	out	std_logic; -- First encoded cathode bit
		C1			:	out	std_logic; -- Second encoded cathode bit
		C0			:	out	std_logic  -- Third encoded cathode bit
	);
end Wall;
----------------------------------------------------------------------

-- Architecture 
architecture Wall_a of Wall is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------
	
	component Three_Bit_Counter is port
		( 
			count		:	in		std_logic; -- Input tells counter to increment by 1
			rst		:	in		std_logic; -- Reset input
			clk		:	in		std_logic; -- Clock input
			en			:	in		std_logic; -- Enable
			
			R2			:	in		std_logic; -- First reset bit 
			R1			:	in		std_logic; -- Second reset bit
			R0			:	in		std_logic; -- Third reset bit
			
			B2			:	out	std_logic; -- First output bit
			B1			:	out	std_logic; -- Second output bit
			B0			:	out	std_logic  -- Third output bit
		);
	end component;
	
	component Two_Bit_LFSR is port
		( 
			en			:	in		std_logic; -- Enable input
			rst		:	in		std_logic; -- Reset input
			clk		:	in		std_logic; -- Clock input
			
			B1			:	out	std_logic; -- First output bit
			B0			:	out	std_logic  -- Second output bit
		);
	end component;
	
	component Wall_Generator is port
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
	end component;

	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal B2		:	std_logic; -- First counter bit signal
	signal B1		:	std_logic; -- Second counter bit signal
	signal B0		:	std_logic; -- Third counter bit signal
	
	signal LFSRen	:	std_logic; -- LFSR enable signal
	
	signal Rand1	:	std_logic; -- First random bit signal
	signal Rand0	:	std_logic; -- Second random bit signal
	
	signal clk0		:	std_logic; -- Inverted clock signal
	
begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------
	
	-- Increments the cathode the Anode is displayed on
	counter	:	Three_Bit_Counter port map
		(
			count	 => '1',
			rst	 => rst,
			clk	 => clk,
			en		 => en ,
			
			R2		 => R2,
			R1		 => R1,
			R0		 => R0,
			 
			B2		 => B2,
			B1		 => B1,
			B0		 => B0
		);
		
	-- Generates a random wall select code
	randomizer	:	Two_Bit_LFSR port map
		(
			en	 => LFSRen,
			rst => rst,
			clk => clk,
			 
			B1	 => Rand1,
			B0	 => Rand0
		);
		
	-- Generates a wall based on the randomly selected number
	generator : Wall_Generator port map
		(
			R1 => rand1,
			R0 => rand0,
			 
			B7 => A7,
			B6 => A6,
			B5 => A5,
			B4 => A4,
			B3 => A3,
			B2 => A2,
			B1 => A1,
			B0 => A0
		);
		
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	clk0 <= NOT clk;
	LFSRen <= NOT(B2 OR B1 OR B0);
	
	C2 <= B2;
	C1 <= B1;
	C0 <= B0;
 			 
end Wall_a; -- .same name as the architecture