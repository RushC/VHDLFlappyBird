------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 14, 2015
-- Lab # and name	: Fianl Project - Flappy Bird
-- Student 1		: Caleb Rush
-- Student 2		: Jerett Johnstone

-- Description		: 7 Segment disply 


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER 

-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Seven_Segment_Display is port
	( 
		clk		:	in			std_logic; -- Clock input
		en			:	in			std_logic; -- Enable input
		rst		:	in			std_logic; -- reset input
		
		A3			:	in			std_logic; -- First bit first number input
		A2			:	in			std_logic; -- Second bit first number input
		A1			:	in			std_logic; -- Third bit first number input
		A0			:	in			std_logic; -- Fourth bit first number input
		
		B3			:	in			std_logic; -- First bit second number input
		B2			:	in			std_logic; -- Second bit second number input
		B1			:	in			std_logic; -- Third bit second number input
		B0			:	in			std_logic; -- Fourth bit second number input
		
		C3			:	in			std_logic; -- First bit third number input
		C2			:	in			std_logic; -- Second bit third number input
		C1			:	in			std_logic; -- Third bit third number input
		C0			:	in			std_logic; -- Fourth bit third number input
		
		D3			:	in			std_logic; -- First bit fourth number input
		D2			:	in			std_logic; -- Second bit fourth number input
		D1			:	in			std_logic; -- Third bit fourth number input
		D0			:	in			std_logic; -- Fourth bit fourth number input
		
		AN3		:	out		std_logic; -- Right most anode
		AN2		:	out		std_logic; -- anode
		AN1		:	out		std_logic; -- anode	
		AN0		:	out		std_logic; -- Left most anode	
		
		CA			:	out		std_logic; -- First cathode
		CB			:	out		std_logic; -- Second cathode
		CC			:	out		std_logic; -- Third cathode	
		CD			:	out		std_logic; -- Fourth cathode	
		CE			:	out		std_logic; -- Fifth cathode
		CF			:	out		std_logic; -- sixth cathode
		CG			:	out		std_logic  -- Seventh cathode	
	);
end Seven_Segment_Display;
----------------------------------------------------------------------

-- Architecture 
architecture Seven_Segment_Display_a of Seven_Segment_Display is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	component Seven_Segment_Driver is port
		( 
			B3		:	in		std_logic; -- Input bit - Most significant
			B2		:	in		std_logic; -- Input bit
			B1		:	in		std_logic; -- Input bit
			B0		:	in		std_logic; -- Input bit - Least significant
			
			CA		:	out	std_logic; -- Output cathode
			CB		:	out	std_logic; -- Output cathode
			CC		:	out	std_logic; -- Output cathode
			CD		:	out	std_logic; -- Output cathode
			CE		:	out	std_logic; -- Output cathode
			CF		:	out	std_logic; -- Output cathode
			CG		:	out	std_logic  -- Output cathode
		);
	end component;
	
	component Three_Bit_Counter is port
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
	end component;
	
	component Four_to_One_MUX is port
		( 
			A			: in 	std_logic; -- first bit input
			B			: in 	std_logic; -- second bit input
			C			: in 	std_logic; -- third bit input
			D			: in 	std_logic; -- fourth bit input
			
			S1			: in 	std_logic; -- first select input
			S0			: in 	std_logic; -- second select input
			
			M			: out std_logic  -- output bit 	
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
	
	signal 	S1			:			std_logic; -- Select bit numoro uno 
	signal	S0			:			std_logic; -- Select bit numero dos
	
	signal 	N3			:			std_logic; -- First bit signal
	signal 	N2			:			std_logic; -- Second bit signal
	signal 	N1			:			std_logic; -- Third bit signal
	signal 	N0			:			std_logic; -- Fourth bit signal
	
	signal 	DA3		:			std_logic; -- First decoded Anode bit
	signal 	DA2		:			std_logic; -- Second decoded Anode bit
	signal 	DA1		:			std_logic; -- Third decoded Anode bit
	signal 	DA0		:			std_logic; -- Fourth decoded Anode bit
	
begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	Driver	: 	Seven_Segment_Driver	port map
		(
			B3	=>	N3,
			B2	=>	N2,
			B1	=>	N1,
			B0	=>	N0,
			
			CA	=>	CA,
			CB	=>	CB,
			CC	=>	CC,
			CD	=>	CD,
			CE	=>	CE,	
			CF	=>	CF,	
			CG	=>	CG
		);	
		
	-- Three bit counter	
	Counter 	: 	Three_Bit_Counter port map
		(
			count	=> '1'	,
		   rst	=> rst	,
		   clk	=> clk	,
		   en		=> en		,
		   
		   R2		=> '0'	,
		   R1		=> '0'	,
		   R0		=> '0'	,
		   
		   B2		=> open	,
		   B1		=> S1		,
		   B0		=> S0
		);
		
	Decoder : Three_Bit_Decoder port map
		(
			S2	=> '0',
			S1	=> S1,
			S0	=> S0,
			
			D7	=> open,
			D6	=> open,
			D5	=> open,
			D4	=> open,
			D3	=> DA3,
			D2	=> DA2,
			D1	=> DA1,
			D0	=> DA0
		);
		
	MUX3 : Four_To_One_MUX port map
		(
			A	=> A3,
			B	=> B3,
			C	=> C3,
			D	=> D3,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> N3
		);
		
	MUX2 : Four_To_One_MUX port map
		(
			A	=> A2,
			B	=> B2,
			C	=> C2,
			D	=> D2,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> N2
		);
		
	MUX1 : Four_To_One_MUX port map
		(
			A	=> A1,
			B	=> B1,
			C	=> C1,
			D	=> D1,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> N1
		);
		
	MUX0 : Four_To_One_MUX port map
		(
			A	=> A0,
			B	=> B0,
			C	=> C0,
			D	=> D0,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> N0
		);
			
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	AN3 <= NOT DA3;
	AN2 <= NOT DA2;
	AN1 <= NOT DA1;
	AN0 <= NOT DA0;
 			 
end Seven_Segment_Display_a; -- .same name as the architecture