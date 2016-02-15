------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Final Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: Game circuit to handle all game logic.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Game is port
	( 
		clk		:	in		std_logic; -- Clock input
		rst		:	in		std_logic; -- Reset input
		en			:	in		std_logic; -- Enable input
		
		Jump		:	in		std_logic; -- Jump input
		Hard		:	in		std_logic; -- Hard mode input
		
		Score		:	out	std_logic; -- Score output
		Lose		:	out	std_logic; -- Lose output
		
		AA7		:	out	std_logic; -- First Anode - First Set
		AA6		:	out	std_logic; -- Second Anode - First Set
		AA5		:	out	std_logic; -- Third Anode - First Set
		AA4		:	out	std_logic; -- Fourth Anode - First Set
		AA3		:	out	std_logic; -- Fifth Anode - First Set
		AA2		:	out	std_logic; -- Sizth Anode - First Set
		AA1		:	out	std_logic; -- Seventh Anode - First Set
		AA0		:	out	std_logic; -- Eigth Anode - First Set
		
		BA7		:	out	std_logic; -- First Anode - Second Set
		BA6		:	out	std_logic; -- Second Anode - Second Set
		BA5		:	out	std_logic; -- Third Anode - Second Set
		BA4		:	out	std_logic; -- Fourth Anode - Second Set
		BA3		:	out	std_logic; -- Fifth Anode - Second Set
		BA2		:	out	std_logic; -- Sizth Anode - Second Set
		BA1		:	out	std_logic; -- Seventh Anode - Second Set
		BA0		:	out	std_logic; -- Eigth Anode - Second Set
		
		CA7		:	out	std_logic; -- First Anode - Third Set
		CA6		:	out	std_logic; -- Second Anode - Third Set
		CA5		:	out	std_logic; -- Third Anode - Third Set
		CA4		:	out	std_logic; -- Fourth Anode - Third Set
		CA3		:	out	std_logic; -- Fifth Anode - Third Set
		CA2		:	out	std_logic; -- Sizth Anode - Third Set
		CA1		:	out	std_logic; -- Seventh Anode - Third Set
		CA0		:	out	std_logic; -- Eigth Anode - Third Set
		
		AC7		:	out	std_logic; -- First Cathode - First Set
		AC6		:	out	std_logic; -- Second Cathode - First Set
		AC5		:	out	std_logic; -- Third Cathode - First Set
		AC4		:	out	std_logic; -- Fourth Cathode - First Set
		AC3		:	out	std_logic; -- Fifth Cathode - First Set
		AC2		:	out	std_logic; -- Sizth Cathode - First Set
		AC1		:	out	std_logic; -- Seventh Cathode - First Set
		AC0		:	out	std_logic; -- Eigth Cathode - First Set
		
		BC7		:	out	std_logic; -- First Cathode - Second Set
		BC6		:	out	std_logic; -- Second Cathode - Second Set
		BC5		:	out	std_logic; -- Third Cathode - Second Set
		BC4		:	out	std_logic; -- Fourth Cathode - Second Set
		BC3		:	out	std_logic; -- Fifth Cathode - Second Set
		BC2		:	out	std_logic; -- Sizth Cathode - Second Set
		BC1		:	out	std_logic; -- Seventh Cathode - Second Set
		BC0		:	out	std_logic; -- Eigth Cathode - Second Set
		
		CC7		:	out	std_logic; -- First Cathode - Third Set
		CC6		:	out	std_logic; -- Second Cathode - Third Set
		CC5		:	out	std_logic; -- Third Cathode - Third Set
		CC4		:	out	std_logic; -- Fourth Cathode - Third Set
		CC3		:	out	std_logic; -- Fifth Cathode - Third Set
		CC2		:	out	std_logic; -- Sizth Cathode - Third Set
		CC1		:	out	std_logic; -- Seventh Cathode - Third Set
		CC0		:	out	std_logic  -- Eigth Cathode - Third Set
	);
end Game;
----------------------------------------------------------------------

-- Architecture 
architecture Game_a of Game is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	component Player is port
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
	end component;
	
	component Wall is port
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
	end component;
	
	component Multiplexer is port
	( 
			A			:	in		std_logic; -- First input -- Chosen when S is 1
			B			:	in		std_logic; -- Second input -- Chosen when S is 0
			S			:	in		std_logic; -- Select input
			
			M			:	out	std_logic  -- Output
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
	
	signal PA7		:			std_logic; -- Player First Anode Bit
	signal PA6		:			std_logic; -- Player Second Anode Bit
	signal PA5		:			std_logic; -- Player Third Anode Bit
	signal PA4		:			std_logic; -- Player Fourth Anode Bit
	signal PA3		:			std_logic; -- Player Fifth Anode Bit
	signal PA2		:			std_logic; -- Player Sixth Anode Bit
	signal PA1		:			std_logic; -- Player Seventh Anode Bit
	signal PA0		:			std_logic; -- Player Eighth Anode Bit
	
	signal W1A7		:			std_logic; -- Wall 1 First Anode Bit
	signal W1A6		:			std_logic; -- Wall 1 Second Anode Bit
	signal W1A5		:			std_logic; -- Wall 1 Third Anode Bit
	signal W1A4		:			std_logic; -- Wall 1 Fourth Anode Bit
	signal W1A3		:			std_logic; -- Wall 1 Fifth Anode Bit
	signal W1A2		:			std_logic; -- Wall 1 Sixth Anode Bit
	signal W1A1		:			std_logic; -- Wall 1 Seventh Anode Bit
	signal W1A0		:			std_logic; -- Wall 1 Eighth Anode Bit
	
	signal W1C2		:			std_logic; -- Wall 1 First Cathode Bit
	signal W1C1		:			std_logic; -- Wall 1 Second Cathode Bit
	signal W1C0		:			std_logic; -- Wall 1 Third Cathode Bit
	
	signal W2A7		:			std_logic; -- Wall 2 First Anode Bit
	signal W2A6		:			std_logic; -- Wall 2 Second Anode Bit
	signal W2A5		:			std_logic; -- Wall 2 Third Anode Bit
	signal W2A4		:			std_logic; -- Wall 2 Fourth Anode Bit
	signal W2A3		:			std_logic; -- Wall 2 Fifth Anode Bit
	signal W2A2		:			std_logic; -- Wall 2 Sixth Anode Bit
	signal W2A1		:			std_logic; -- Wall 2 Seventh Anode Bit
	signal W2A0		:			std_logic; -- Wall 2 Eighth Anode Bit
	
	signal W2C2		:			std_logic; -- Wall 2 First Cathode Bit
	signal W2C1		:			std_logic; -- Wall 2 Second Cathode Bit
	signal W2C0		:			std_logic; -- Wall 2 Third Cathode Bit
	
	signal W2MA7	:			std_logic; -- Wall 2 First MUX Bit
	signal W2MA6	:			std_logic; -- Wall 2 Second MUX Bit
	signal W2MA5	:			std_logic; -- Wall 2 Third MUX Bit
	signal W2MA4	:			std_logic; -- Wall 2 Fourth MUX Bit
	signal W2MA3	:			std_logic; -- Wall 2 Fifth MUX Bit
	signal W2MA2	:			std_logic; -- Wall 2 Sixth MUX Bit
	signal W2MA1	:			std_logic; -- Wall 2 Seventh MUX Bit
	signal W2MA0	:			std_logic; -- Wall 2 Eighth MUX Bit
	
	signal W2MC2	:			std_logic; -- Wall 2 First MUX Bit
	signal W2MC1	:			std_logic; -- Wall 2 Second MUX Bit
	signal W2MC0	:			std_logic; -- Wall 2 Third MUX Bit
	
	signal hit		:			std_logic; -- Hit signal
	signal overflow:			std_logic; -- Overflow from player signal

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- Player 
	Flappy : Player port map
		(
			clk	 => clk,
			rst	 => rst,
			en		 => en,
			 
			R2		 => '1',
			R1		 => '0',
			R0		 => '0',
			 
			Jump	 => Jump,
			 
			A7		 => PA7,
			A6		 => PA6,
			A5		 => PA5,
			A4		 => PA4,
			A3		 => PA3,
			A2		 => PA2,
			A1		 => PA1,
			A0		 => PA0,
			
			Overflow => overflow
		);
		
	-- First wall (always on)	
	Wall1 : Wall port map
		(
			clk => clk,
			rst => rst,
			en	 => en,
			 
			R2	 => '0',
			R1	 => '0',
			R0	 => '0',
			 
			A7	 => W1A7,
			A6	 => W1A6,
			A5	 => W1A5,
			A4	 => W1A4,
			A3	 => W1A3,
			A2	 => W1A2,
			A1	 => W1A1,
			A0	 => W1A0,
			       
			C2	 => W1C2,
			C1	 => W1C1,
			C0	 => W1C0
		);
	
	-- Second Wall (Hard mode only)
	Wall2 : Wall port map
		(
			clk => clk,
			rst => rst,
			en	 => en,
			 
			R2	 => '1',
			R1	 => '0',
			R0	 => '0',
			 
			A7	 => W2A7,
			A6	 => W2A6,
			A5	 => W2A5,
			A4	 => W2A4,
			A3	 => W2A3,
			A2	 => W2A2,
			A1	 => W2A1,
			A0	 => W2A0,
			       
			C2	 => W2C2,
			C1	 => W2C1,
			C0	 => W2C0
		);
		
	-- MUX to control second wall first anode
	A_MUX7 : Multiplexer port map
		(
			A => W2A7,
			B => '0',
			S => Hard,
			 
			M => W2MA7
		);
		
	-- MUX to control second wall second anode
	A_MUX6 : Multiplexer port map
		(
			A => W2A6,
			B => '0',
			S => Hard,
			 
			M => W2MA6
		);
		
	-- MUX to control second wall third anode
	A_MUX5 : Multiplexer port map
		(
			A => W2A5,
			B => '0',
			S => Hard,
			 
			M => W2MA5
		);
		
	-- MUX to control second wall fourth anode
	A_MUX4 : Multiplexer port map
		(
			A => W2A4,
			B => '0',
			S => Hard,
			 
			M => W2MA4
		);
		
	-- MUX to control second wall fifth anode
	A_MUX3 : Multiplexer port map
		(
			A => W2A3,
			B => '0',
			S => Hard,
			 
			M => W2MA3
		);
		
	-- MUX to control second wall sixth anode
	A_MUX2 : Multiplexer port map
		(
			A => W2A2,
			B => '0',
			S => Hard,
			 
			M => W2MA2
		);
		
	-- MUX to control second wall seventh anode
	A_MUX1 : Multiplexer port map
		(
			A => W2A1,
			B => '0',
			S => Hard,
			 
			M => W2MA1
		);
		
	-- MUX to control second wall eighth anode
	A_MUX0 : Multiplexer port map
		(
			A => W2A0,
			B => '0',
			S => Hard,
			 
			M => W2MA0
		);
		
	-- MUX to control the second wall first cathode
	C_MUX2 : Multiplexer port map
		(
			A => W2C2,
			B => '0',
			S => Hard,
			 
			M => W2MC2
		);
		
	-- MUX to control the second wall second cathode
	C_MUX1 : Multiplexer port map
		(
			A => W2C1,
			B => '0',
			S => Hard,
			 
			M => W2MC1
		);
		
	-- MUX to control the second wall third cathode
	C_MUX0 : Multiplexer port map
		(
			A => W2C0,
			B => '0',
			S => Hard,
			 
			M => W2MC0
		);
		
	-- Player cathode decoder 
	PCDecoder : Three_Bit_Decoder port map
		(
			S2 => '1',
			S1 => '1',
			S0 => '1',
			
			D7 => AC7,
			D6 => AC6,
			D5 => AC5,
			D4 => AC4,
			D3 => AC3,
			D2 => AC2,
			D1 => AC1,
			D0 => AC0
		);
		
	-- Wall1 cathode decoder 
	W1CDecoder : Three_Bit_Decoder port map
		(
			S2 => W1C2,
			S1 => W1C1,
			S0 => W1C0,
			
			D7 => BC7,
			D6 => BC6,
			D5 => BC5,
			D4 => BC4,
			D3 => BC3,
			D2 => BC2,
			D1 => BC1,
			D0 => BC0
		);
		
	-- Wall2 cathode decoder 
	W2CDecoder : Three_Bit_Decoder port map
		(
			S2 => W2MC2,
			S1 => W2MC1,
			S0 => W2MC0,
			
			D7 => CC7,
			D6 => CC6,
			D5 => CC5,
			D4 => CC4,
			D3 => CC3,
			D2 => CC2,
			D1 => CC1,
			D0 => CC0
		);
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	hit <= ((W1C2 AND W1C1 AND W1C0) AND ((PA7 AND W1A7) OR (PA6 AND W1A6) OR (PA5 AND W1A5) OR (PA4 AND W1A4) OR (PA3 AND W1A3) OR (PA2 AND W1A2) OR (PA1 AND W1A1) OR (PA0 AND W1A0))) OR ((W2MC2 AND W2MC1 AND W2MC0) AND ((PA7 AND W2MA7) OR (PA6 AND W2MA6) OR (PA5 AND W2MA5) OR (PA4 AND W2MA4) OR (PA3 AND W2MA3) OR (PA2 AND W2MA2) OR (PA1 AND W2MA1) OR (PA0 AND W2MA0)));
	Score <= (NOT hit) AND ((W1C2 AND W1C1 AND W1C0) OR (W2MC2 AND W2MC1 AND W2MC0));
	Lose <= hit;
	
	AA7 <= PA7;
	AA6 <= PA6;
	AA5 <= PA5;
	AA4 <= PA4;
	AA3 <= PA3;
	AA2 <= PA2;
	AA1 <= PA1;
	AA0 <= PA0;
	
	BA7 <= W1A7;
	BA6 <= W1A6;
	BA5 <= W1A5;
	BA4 <= W1A4;
	BA3 <= W1A3;
	BA2 <= W1A2;
	BA1 <= W1A1;
	BA0 <= W1A0;
	
	CA7 <= W2MA7;
	CA6 <= W2MA6;
	CA5 <= W2MA5;
	CA4 <= W2MA4;
	CA3 <= W2MA3;
	CA2 <= W2MA2;
	CA1 <= W2MA1;
	CA0 <= W2MA0;
 			 
end Game_a; -- .same name as the architecture