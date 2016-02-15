------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Fianl Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: 2:1 MUX.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Multiplexer is port
	( 
		A			:	in		std_logic; -- First input -- Chosen when S is 1
		B			:	in		std_logic; -- Second input -- Chosen when S is 0
		S			:	in		std_logic; -- Select input
		
		M			:	out	std_logic  -- Output
	);
end Multiplexer;
----------------------------------------------------------------------

-- Architecture 
architecture Multiplexer_a of Multiplexer is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

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
	
	signal D1		:			std_logic; -- First decoder output signal
	signal D0		:			std_logic; -- Second decoder output signal

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- Decoder to decode the select bit. A 3-Bit Decoder is used due to convenience.
	Decoder	:	Three_Bit_Decoder	port map
		(
			S2 => '0'	,	
			S1 => '0'	,
			S0 => S		,
			 
			D7 => open	,
			D6 => open	,
			D5 => open	,
			D4 => open	,
			D3 => open	,
			D2 => open	,
			D1 => D1		,
			D0 => D0
		);
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	M <= (A AND D1) OR (B AND D0);
 			 
end Multiplexer_a; -- .same name as the architecture