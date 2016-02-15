------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Fianl Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: 3-Bit Counter.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Three_Bit_Counter is port
	( 
		count			:	in		std_logic; -- Input tells counter to increment by 1
		rst			:	in		std_logic; -- Reset input
		clk			:	in		std_logic; -- Clock input
		en				:	in		std_logic; -- Clock enable
		
		R2				:	in		std_logic; -- First reset bit 
		R1				:	in		std_logic; -- Second reset bit
		R0				:	in		std_logic; -- Third reset bit
		
		B2				:	out	std_logic; -- First output bit
		B1				:	out	std_logic; -- Second output bit
		B0				:	out	std_logic  -- Third output bit
	);
end Three_Bit_Counter;
----------------------------------------------------------------------

-- Architecture 
architecture Three_Bit_Counter_a of Three_Bit_Counter is
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
	
	component dff270 is port
		(
			clk 	: in std_logic ;
			clken	: in std_logic ;
			rst 	: in std_logic ;
			d 		: in std_logic ;
			q 		: out std_logic
		);
	end component;
	
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
	
	signal C2	:	std_logic; -- Second place carry bit
	signal C1	:	std_logic; -- First place carry bit
	
	signal PB2	:	std_logic; -- First present bit
	signal PB1	:	std_logic; -- Second present bit
	signal PB0	:	std_logic; -- Third present bit
	
	signal SB2	:	std_logic; -- First sum bit
	signal SB1	:	std_logic; -- Second sum bit
	signal SB0	:	std_logic; -- Third sum bit
	
	signal NB2	:	std_logic; -- First next bit
	signal NB1	:	std_logic; -- Second next bit
	signal NB0	:	std_logic; -- Third next bit

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------
	
	-- DFF to hold the first bit
	Bit2 : dff270 port map
		(
			clk 	 => clk,
			clken	 => en ,
			rst 	 => '0',
			d 		 => NB2,
			q 		 => PB2
		);
		
	-- DFF to hold the second bit
	Bit1 : dff270 port map
		(
			clk 	 => clk,
			clken	 => en ,
			rst 	 => '0',
			d 		 => NB1,
			q 		 => PB1
		);
		
	-- DFF to hold the third bit
	Bit0 : dff270 port map
		(
			clk 	 => clk,
			clken	 => en ,
			rst 	 => '0',
			d 		 => NB0,
			q 		 => PB0
		);
		
	-- First Place Adder
	Add2 : Bit_Adder port map
		(
			B1 => PB2 ,
			B2 => '0' ,
			CI => C2  ,
			 
			S	=> SB2 ,
			CO => open
		);
		
	-- Second Place Adder
	Add1 : Bit_Adder port map
		(
			B1 => PB1 ,
			B2 => '0' ,
			CI => C1  ,
			 
			S	=> SB1 ,
			CO => C2
		);
		
	-- Third Place Adder
	Add0 : Bit_Adder port map
		(
			B1 => PB0 ,
			B2 => count ,
			CI => '0',
			 
			S	=> SB0 ,
			CO => C1
		);
		
	-- MUX used to change the next first bit to its reset value when reset is 1
	MUX2 : Multiplexer port map
		(
			A => R2,
			B => SB2,
			S => rst,
			 
			M => NB2
		);
		
	-- MUX used to change the next second bit to its reset value when reset is 1
	MUX1 : Multiplexer port map
		(
			A => R1,
			B => SB1,
			S => rst,
			 
			M => NB1
		);
		
	-- MUX used to change the next third bit to its reset value when reset is 1
	MUX0 : Multiplexer port map
		(
			A => R0,
			B => SB0,
			S => rst,
			 
			M => NB0
		);
		
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	B2 <= PB2;
	B1 <= PB1;
	B0 <= PB0;
 			 
end Three_Bit_Counter_a; -- .same name as the architecture