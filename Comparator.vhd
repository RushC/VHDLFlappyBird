------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 20, 2015
-- Lab # and name	: Project Flappy Bird
-- Student 1		: Qaleb Rush
-- Student 3		: Jerett Johnstone

-- Description		: Comparator 


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------

-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Comparator is port
	( 
		A3			: in std_logic		; 	-- Most significant first bit
		A2			: in std_logic		; 	-- Mid first bit
		A1			: in std_logic		; 	-- Mid first bit
		A0			: in std_logic		; 	-- Least significant first bit
				
		B3			: in std_logic		; 	-- Most significant second bit	
		B2			: in std_logic		; 	-- Mid first bit
		B1			: in std_logic		; 	-- Mid first bit
		B0			: in std_logic		; 	-- Least significant second bit
		
		Output  : out std_logic			-- output to see if B>A	
	);
end Comparator;
----------------------------------------------------------------------

-- Architecture 
architecture Comparator_a of Comparator is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	------------------------333-------------------------------

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
	
	signal 	NB0		:	std_logic; -- Inverse first B bit
	signal 	NB1		:	std_logic; -- Inverse second B bit
	signal 	NB2		:	std_logic; -- Inverse third B bit
	signal 	NB3		:	std_logic; -- Inverse fourth B bit
	
	signal 	CO0		: 	std_logic; -- least significant carry out
	signal 	CO1		: 	std_logic; -- middle bit carry out
	signal 	CO2		: 	std_logic; -- middle bit carry out
	signal 	CO3		: 	std_logic; -- most significant carry out
	signal 	CO4		: 	std_logic; -- sign bit carry out
	
	
	signal 	S4			:	std_logic; -- Most significant sum bit 
	
begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- least significant comparator
	overflow0	: 	Bit_Adder port map
		(
			B1		=> A0,
			B2		=> NB0, 
			CI		=> '1',
			CO		=> CO0,
			S		=>	open
		);
		
	-- comparator
	overflow1	: 	Bit_Adder port map
		(
			B1		=> A1,
			B2		=> NB1,
			CI		=> CO0,
			CO		=> CO1,
			S		=>	open
		);
		
	-- comparator
	overflow2	: 	Bit_Adder port map
		(
			B1		=> A2,
			B2		=> NB2,
			CI		=> CO1,
			CO		=> CO2,
			S		=> open
		);
		
	-- most significant comparator
	overflow3	: 	Bit_Adder port map
		(
			B1		=> A3,
			B2		=> NB3,
			CI		=> CO2,
			CO		=> CO3,
			S		=>	open
		);	
		
	-- Sign bti adder	
	overflow4	: 	Bit_Adder port map
		(
			B1		=> '0',
			B2		=> '1',
			CI		=> CO3,
			CO		=> CO4,
			S		=>	S4
		);	
		
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	NB0	<= NOT B0;
	NB1	<= NOT B1;
	NB2	<= NOT B2;
	NB3	<= NOT B3;
	output <= ((CO3 XOR CO4) XOR S4);
 			 
end Comparator_a; -- .same name as the architecture