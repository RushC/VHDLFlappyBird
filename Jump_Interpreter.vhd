------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Final Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: Outputs a 3-bit number representing the number of cathodes to move by based on whether or not the player jumped.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Jump_Interpreter is port
	( 
		clk			:	in		std_logic; -- Clock input
		en				:	in		std_logic; -- Enable input
		rst			:	in		std_logic; -- Reset input
	
		Button		:	in		std_logic; -- Jump input signal
		
		B2				:	out	std_logic; -- First output bit
		B1				:	out	std_logic; -- Second output bit
		B0				:	out	std_logic  -- Third output bit
	);
end Jump_Interpreter;
----------------------------------------------------------------------

-- Architecture 
architecture Jump_Interpreter_a of Jump_Interpreter is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	component Multiplexer is port
		( 
			A			:	in		std_logic; -- First input -- Chosen when S is 1
			B			:	in		std_logic; -- Second input -- Chosen when S is 0
			S			:	in		std_logic; -- Select input
			
			M			:	out	std_logic  -- Output
		);
	end component;
	
	component low_SR_latch is port
		( 
			set		: in std_logic		; 	-- input to set output to 1  		
			reset		: in std_logic		; 	-- input to set output to 0
			
			output	: out std_logic		-- active low SR latch output 
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
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal set			:	std_logic; -- Set signal to set the SR-Latch
	signal reset		:	std_logic; -- Reset signal to reset the SR-Latch
	
	signal sr_q			:	std_logic; -- SR-Latch output signal
	signal dff_q		:	std_logic; -- DFF output signal
	signal jump			:	std_logic; -- Jump signal

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- MUX to select the first output bit
	MUX2 : Multiplexer port map
		(
			A => '0',
			B => '1',
			S => jump,
			 
			M => B2
		);
		
	-- MUX to select the second output bit
	MUX1 : Multiplexer port map
		(
			A => '1',
			B => '1',
			S => jump,
			 
			M => B1
		);
		
	-- MUX to select the third output bit
	MUX0 : Multiplexer port map
		(
			A => '0',
			B => '1',
			S => jump,
			 
			M => B0
		);
		
	-- SR-Latch to hold the appropriate output until the clock accepts it.
	LATCH : low_SR_latch port map
		(
			set	 => set,
			reset	 => reset,
			 
			output => sr_q
		);
		
	-- DFF to hold the reset signal so that the reset is properly timed
	RESET_HOLDER : dff270 port map
		(
			clk 	 	=> clk,
			clken 	=> en,
			rst 	 	=> '0',
			d 	 		=> rst,
			q 	 		=> dff_q
		);
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	set <= NOT Button OR dff_q;
	reset <= NOT dff_q;
	jump <= sr_q OR Button;
 			 
end Jump_Interpreter_a; -- .same name as the architecture