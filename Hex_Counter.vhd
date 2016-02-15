------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 7, 2015
-- Lab # and name	: Lab 8 - SCORE!
-- Student 1		: Qaleb Rush
-- Student 3		: Jerett Johnstone

-- Description		: Hex digit counter


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Hex_Counter is port
	( 
		count			:	in		std_logic; -- Count input 	- Tells the counter to increment number
		clk			:	in		std_logic; -- Clock input 	- Used to control the DFFs
		rst			:	in		std_logic; -- Reset input 	- Used to reset the number to 0.
		en				:	in		std_logic; -- Enable input
			
		B3				:	out	std_logic; -- Output bit 	- Most significant
		B2				:	out	std_logic; -- Output bit
		B1				:	out	std_logic; -- Output bit
		B0				:	out	std_logic; -- Output bit 	- Least significant
		
		Increment	:	out	std_logic  -- Increment the next digit by 1
	);
end Hex_Counter;
----------------------------------------------------------------------

-- Architecture 
architecture Hex_Counter_a of Hex_Counter is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	component dff270 is port
		(
			 clk 	: in std_logic ;
			 clken: in std_logic ;
			 rst 	: in std_logic ;
			 d 	: in std_logic ;
			 
			 q 	: out std_logic
		 );
	end component;
	
	component Bit_Adder is port
		(
			B1		:	in		std_logic; -- First bit to add
			B2		:	in		std_logic; -- Second bit to add
			CI		:	in		std_logic; -- Carry in from a previous addition
			
			S		:	out	std_logic; -- Sum of the two bits
			CO		:	out	std_logic  -- Carry out of the sum
		);
	end component;
	
	component Ten_Comparator is port
	( 
		B3			:	in		std_logic; -- First input bit
		B2			:	in		std_logic; -- Second input bit
		B1			:	in		std_logic; -- Third input bit
		B0			:	in		std_logic; -- Fourth input bit
		
		output	:	out	std_logic  -- Output - Equal to 10
	);
	end component;
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal PB3	:			std_logic; -- Present number bit	
	signal PB2	:			std_logic; -- Present number bit	
	signal PB1	:			std_logic; -- Present number bit	
	signal PB0	:			std_logic; -- Present number bit	
	
	signal SB3	:			std_logic; -- Sum number bit	
	signal SB2	:			std_logic; -- Sum number bit	
	signal SB1	:			std_logic; -- Sum number bit	
	signal SB0	:			std_logic; -- Sum number bit	
	
	signal NB3	:			std_logic; -- Next number bit	
	signal NB2	:			std_logic; -- Next number bit	
	signal NB1	:			std_logic; -- Next number bit	
	signal NB0	:			std_logic; -- Next number bit	
	
	signal C3	:			std_logic; -- Carry signal for 3rd place adder
	signal C2	:			std_logic; -- Carry signal for 2nd place adder
	signal C1	:			std_logic; -- Carry signal for 1st place adder

	signal Ten	:			std_logic; -- Signal signifying equality to 10 aka A
	
begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------
	
	-- DFF to store the most significant bit
	BIT3	:	dff270	port map
		(
			clk 		=> 	clk	,
			clken		=>		en		,
			rst 		=>		rst	,
			d 			=>		NB3	,
			
			q 			=>		PB3	
		);
		
	-- DFF to store the 2nd bit
	BIT2	:	dff270	port map
		(
			clk 		=> 	clk	,
			clken		=>		en		,
			rst 		=>		rst	,
			d 			=>		NB2	,
			
			q 			=>		PB2	
		);
		
	-- DFF to store the 1st bit
	BIT1	:	dff270	port map
		(
			clk 		=> 	clk	,
			clken		=>		en	,
			rst 		=>		rst	,
			d 			=>		NB1	,
			
			q 			=>		PB1	
		);
		
	-- DFF to store the least significant bit
	BIT0	:	dff270	port map
		(
			clk 		=> 	clk	,
			clken		=>		en	,
			rst 		=>		rst	,
			d 			=>		NB0	,
			
			q 			=>		PB0	
		);

	-- Adder for the 4th place
	PLACE3	:	Bit_Adder	port map
		(
			B1 	=> 	'0'	,
			B2		=>		PB3	,
			CI		=>		C3		,
			
			S		=>		SB3	,
			CO		=>		open
		);
		
	-- Adder for the 3rd place
	PLACE2	:	Bit_Adder	port map
		(
			B1 	=> 	'0'	,
			B2		=>		PB2	,
			CI		=>		C2		,
			
			S		=>		SB2	,
			CO		=>		C3
		);
		
	-- Adder for the 2nd place
	PLACE1	:	Bit_Adder	port map
		(
			B1 	=> 	'0'	,
			B2		=>		PB1	,
			CI		=>		C1		,
			
			S		=>		SB1	,
			CO		=>		C2
		);
		
	-- Adder for the 1st place
	PLACE0	:	Bit_Adder	port map
		(
			B1 	=> 	count	,
			B2		=>		PB0	,
			CI		=>		'0'	,
			
			S		=>		SB0	,
			CO		=>		C1
		);
	
	-- Ten Comparator
	comparator : Ten_Comparator port map
	(
		B3		 => PB3,
		B2		 => PB2,
		B1		 => PB1,
		B0		 => PB0,
		 
		output => Ten
	);
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	B3 <= PB3;
	B2 <= PB2;
	B1 <= PB1;
	B0 <= PB0;
	
	NB3 <= SB3 AND NOT Ten;
	NB2 <= SB2 AND NOT Ten;
	NB1 <= SB1 AND NOT Ten;
	NB0 <= SB0 AND NOT Ten;
	
	Increment <= Ten;
 			 
end Hex_Counter_a; -- .same name as the architecture