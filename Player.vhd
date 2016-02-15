------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Final Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: Outputs 8 anodes that represent the player. Of the 8 anodes, only one will be active. The jump
--                  input indicates when the player should jump(1) and when the player should do nothing(0). The
--                  reset bits (R2 - R0) represent the default position of the player. The 8 bits that are decoded
--                  from these bits are the anodes this component will output when RST is 1.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Player is port
	( 
		clk			:	in		std_logic; -- Clock input
		rst			:	in		std_logic; -- Reset input
		en				:	in		std_logic; -- Enable input
		
		R2				:	in		std_logic; -- First reset bit
		R1				:	in		std_logic; -- Second reset bit
		R0				:	in		std_logic; -- Third reset bit
		
		Jump			:	in		std_logic; -- Jump input
		
		A7				:	out	std_logic; -- Output anode
		A6				:	out	std_logic; -- Output anode
		A5				:	out	std_logic; -- Output anode
		A4				:	out	std_logic; -- Output anode
		A3				:	out	std_logic; -- Output anode
		A2				:	out	std_logic; -- Output anode
		A1				:	out	std_logic; -- Output anode
		A0				:	out	std_logic; -- Output anode
		
		Overflow		:	out	std_logic  -- Overflow output
	);
end Player;
----------------------------------------------------------------------

-- Architecture 
architecture Player_a of Player is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	component Jump_Interpreter is port
		( 
			clk			:	in		std_logic; -- Clock input
			en				:	in		std_logic; -- Enable input
			rst			:	in		std_logic; -- Reset input 
	
			Button		:	in		std_logic; -- Jump input signal
			
			B2				:	out	std_logic; -- First output bit
			B1				:	out	std_logic; -- Second output bit
			B0				:	out	std_logic  -- Third output bit
		);
	end component;
	
	component Three_Bit_Adder is port
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
			CO				:	out	std_logic  -- Carry out output
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
	
	component dff270 is port
		(
			 clk 	: in std_logic ;
			 clken	: in std_logic ;
			 rst 	: in std_logic ;
			 d 	: in std_logic ;
			 q 	: out std_logic
		 );
	end component;
	
	component Three_Bit_Decoder is port
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
	end component;
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal J2		:			std_logic; -- First jump bit
	signal J1		:			std_logic; -- Second jump bit
	signal J0		:			std_logic; -- Third jump bit
	
	signal S2		:			std_logic; -- First sum bit
	signal S1		:			std_logic; -- Second sum bit
	signal S0		:			std_logic; -- Third sum bit
	
	signal N2		:			std_logic; -- First next bit
	signal N1		:			std_logic; -- Second next bit
	signal N0		:			std_logic; -- Third next bit
	
	signal P2		:			std_logic; -- First present bit
	signal P1		:			std_logic; -- Second present bit
	signal P0		:			std_logic; -- Third present bit
	
	signal jumprst	:			std_logic; -- Reset ssignal to reset the jump interpreter
	
begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- Interpreter to translate the Jump input to a 3-Bit number
	Interpreter : Jump_Interpreter port map
		(
			clk	 => clk,
			en		 => en,
			rst 	 => jumprst,
			
			Button => Jump,
			 
			B2		 => J2,
			B1		 => J1,
			B0		 => J0
		);
		
	-- Adder to add the input's translated 3-Bit number to the stored 3-Bit number
	Adder : Three_Bit_Adder port map
		(
			A2 => J2,
			A1 => J1,
			A0 => J0,
			 
			B2 => P2,
			B1 => P1,
			B0 => P0,
			 
			S2 => S2,
			S1 => S1,
			S0 => S0,
			CO => Overflow
		);
		
	-- MUX to select either the sum bit or the reset bit to store as the first bit
	MUX2 : Multiplexer port map
		(
			A => R2,
			B => S2,
			S => rst,
			 
			M => N2
		);
		
	-- MUX to select either the sum bit or the reset bit to store as the second bit
	MUX1 : Multiplexer port map
		(
			A => R1,
			B => S1,
			S => rst,
			 
			M => N1
		);
		
	-- MUX to select either the sum bit or the reset bit to store as the third bit
	MUX0 : Multiplexer port map
		(
			A => R0,
			B => S0,
			S => rst,
			 
			M => N0
		);
		
	-- DFF to store the first bit
	DFF2 : dff270 port map
		(
			clk 		=> clk,
			clken 	=> en,
			rst 	 	=> '0',
			d 	 		=> N2,
			q 	 		=> P2
		);
		
	-- DFF to store the second bit
	DFF1 : dff270 port map
		(
			clk 		=> clk,
			clken 	=> en,
			rst 	 	=> '0',
			d 	 		=> N1,
			q 	 		=> P1
		);
		
	-- DFF to store the third bit
	DFF0 : dff270 port map
		(
			clk 		=> clk,
			clken 	=> en,
			rst 	 	=> '0',
			d 	 		=> N0,
			q 	 		=> P0
		);
		
	-- Decoder to decode the stored 3-Bit number into the 8 output anodes
	Decoder : Three_Bit_Decoder port map
		(
			S2 => P2,
			S1 => P1,
			S0 => P0,
			
			D7 => A7,
			D6 => A6,
			D5 => A5,
			D4 => A4,
			D3 => A3,
			D2 => A2,
			D1 => A1,
			D0 => A0
		);
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	jumprst <= (NOT J2 AND J1 AND NOT J0) OR rst;
 			 
end Player_a; -- .same name as the architecture