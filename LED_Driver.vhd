------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Final Project - Flappy Bird
-- Student 1		: Qaleb Rush
-- Student 3		: Jerett Johnpebble

-- Description		: LED display.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity LED_Driver is port
	( 
		clk		: in 		std_logic; -- Clock input 
		rst		: in 		std_logic; -- Reset input 
		en 		: in 		std_logic; -- Enablerrererer
	
		AA7		: in 		std_logic; -- first number first anode
		AA6		: in 		std_logic; -- first number Second anode
		AA5		: in 		std_logic; -- first number Third anode
		AA4		: in 		std_logic; -- first number Fourth anode
		AA3		: in 		std_logic; -- first number Fifth anode
		AA2		: in 		std_logic; -- first number Sixth anode
		AA1		: in 		std_logic; -- first number Seventh anode
		AA0		: in 		std_logic; -- first number Eighth anode     
		
		AB7		: in 		std_logic; -- Second number first anode
		AB6		: in 		std_logic; -- Second number Second anode
		AB5		: in 		std_logic; -- Second number Third anode
		AB4		: in 		std_logic; -- Second number Fourth anode
		AB3		: in 		std_logic; -- Second number Fifth anode
		AB2		: in 		std_logic; -- Second number Sixth anode
		AB1		: in 		std_logic; -- Second number Seventh anode
		AB0		: in 		std_logic; -- Second number Eighth anode
		
		AC7		: in 		std_logic; -- Third number first anode
		AC6		: in 		std_logic; -- Third number Second anode
		AC5		: in 		std_logic; -- Third number Third anode
		AC4		: in 		std_logic; -- Third number Fourth anode
		AC3		: in 		std_logic; -- Third number Fifth anode
		AC2		: in 		std_logic; -- Third number Sixth anode
		AC1		: in 		std_logic; -- Third number Seventh anode
		AC0		: in 		std_logic; -- Third number Eighth anode
		
		AD7		: in 		std_logic; -- Fourth number first anode
		AD6		: in 		std_logic; -- Fourth number Second anode
		AD5		: in 		std_logic; -- Fourth number Third anode
		AD4		: in 		std_logic; -- Fourth number Fourth anode
		AD3		: in 		std_logic; -- Fourth number Fifth anode
		AD2		: in 		std_logic; -- Fourth number Sixth anode
		AD1		: in 		std_logic; -- Fourth number Seventh anode
		AD0		: in 		std_logic; -- Fourth number Eighth anode
		
		CA7		: in 		std_logic; -- first number first cathode
		CA6		: in 		std_logic; -- first number Second cathode
		CA5		: in 		std_logic; -- first number Third cathode
		CA4		: in 		std_logic; -- first number Fourth cathode
		CA3		: in 		std_logic; -- first number Fifth cathode
		CA2		: in 		std_logic; -- first number Sixth cathode
		CA1		: in 		std_logic; -- first number Seventh cathode
		CA0		: in 		std_logic; -- first number Eighth cathode     
		
		CB7		: in 		std_logic; -- Second number first cathode
		CB6		: in 		std_logic; -- Second number Second cathode
		CB5		: in 		std_logic; -- Second number Third cathode
		CB4		: in 		std_logic; -- Second number Fourth cathode
		CB3		: in 		std_logic; -- Second number Fifth cathode
		CB2		: in 		std_logic; -- Second number Sixth cathode
		CB1		: in 		std_logic; -- Second number Seventh cathode
		CB0		: in 		std_logic; -- Second number Eighth cathode
		
		CC7		: in 		std_logic; -- Third number first cathode
		CC6		: in 		std_logic; -- Third number Second cathode
		CC5		: in 		std_logic; -- Third number Third cathode
		CC4		: in 		std_logic; -- Third number Fourth cathode
		CC3		: in 		std_logic; -- Third number Fifth cathode
		CC2		: in 		std_logic; -- Third number Sixth cathode
		CC1		: in 		std_logic; -- Third number Seventh cathode
		CC0		: in 		std_logic; -- Third number Eighth cathode
		
		CD7		: in 		std_logic; -- Fourth number first cathode
		CD6		: in 		std_logic; -- Fourth number Second cathode
		CD5		: in 		std_logic; -- Fourth number Third cathode
		CD4		: in 		std_logic; -- Fourth number Fourth cathode
		CD3		: in 		std_logic; -- Fourth number Fifth cathode
		CD2		: in 		std_logic; -- Fourth number Sixth cathode
		CD1		: in 		std_logic; -- Fourth number Seventh cathode
		CD0		: in 		std_logic; -- Fourth number Eighth cathode
		
		A7			: out		std_logic; -- First anode output
		A6			: out 	std_logic; -- Second anode output
		A5			: out 	std_logic; -- Third anode output
		A4			: out 	std_logic; -- Fourth anode output
		A3			: out 	std_logic; -- Fifth anode output
		A2			: out 	std_logic; -- Sixth anode output
		A1			: out 	std_logic; -- Seventh anode output
		A0			: out 	std_logic; -- Eighth anode output
			
		C7			: out 	std_logic; -- first cathode output
		C6			: out 	std_logic; -- Second cathode output
		C5			: out 	std_logic; -- Third cathode output
		C4			: out 	std_logic; -- Fourth cathode output 
		C3			: out 	std_logic; -- Fifth cathode output 
		C2			: out 	std_logic; -- Sixth cathode output
		C1			: out 	std_logic; -- Seventh cathode output
		C0			: out 	std_logic  -- Eighth cathode output
	);
end LED_Driver;
----------------------------------------------------------------------

-- Architecture 
architecture LED_Driver_a of LED_Driver is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

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
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal S1		:		std_logic; -- Select bit 1 
	signal S0		:		std_logic; -- Select bit 2

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- Counter to cycle through the select bits 
	Counter 	:	Three_Bit_Counter  port map
		(	
			count	=> '1'	,
			rst	=> rst 	,
			clk	=> clk	,
			en		=> en		,
			
			R2		=> '0'	,
			R1		=> '0'	,
			R0		=> '0'	,
			
			B2		=> open	,
			B1		=> S1		,
			B0		=> S0
		);	
	
	-- First anode mux
	AMUX7		:	Four_to_One_MUX port map 
		(
			A	=> AA7,
			B	=> AB7,
			C	=> AC7,
			D	=> AD7,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> A7
		);	

	-- Second anode mux
	AMUX6		:	Four_to_One_MUX port map 
		(
			A	=> AA6,
			B	=> AB6,
			C	=> AC6,
			D	=> AD6,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> A6
		);	
			
	-- Third anode mux
	AMUX5		:	Four_to_One_MUX port map 
		(
			A	=> AA5,
			B	=> AB5,
			C	=> AC5,
			D	=> AD5,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> A5
		);	

	-- Fourth anode mux
	AMUX4		:	Four_to_One_MUX port map 
		(
			A	=> AA4,
			B	=> AB4,
			C	=> AC4,
			D	=> AD4,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> A4
		);	

	-- Fifth anode mux
	AMUX3		:	Four_to_One_MUX port map 
		(
			A	=> AA3,
			B	=> AB3,
			C	=> AC3,
			D	=> AD3,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> A3
		);	

	-- Sixth anode mux
	AMUX2		:	Four_to_One_MUX port map 
		(
			A	=> AA2,
			B	=> AB2,
			C	=> AC2,
			D	=> AD2,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> A2
		);	

	-- Seventh anode mux
	AMUX1		:	Four_to_One_MUX port map 
		(
			A	=> AA1,
			B	=> AB1,
			C	=> AC1,
			D	=> AD1,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> A1
		);	

	-- Eighth anode mux
	AMUX0		:	Four_to_One_MUX port map 
		(
			A	=> AA0,
			B	=> AB0,
			C	=> AC0,
			D	=> AD0,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> A0
		);		
		
	-- First cathode mux
	CMUX7		:	Four_to_One_MUX port map 
		(
			A	=> CA7,
			B	=> CB7,
			C	=> CC7,
			D	=> CD7,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> C7
		);	

	-- Second cathode mux
	CMUX6		:	Four_to_One_MUX port map 
		(
			A	=> CA6,
			B	=> CB6,
			C	=> CC6,
			D	=> CD6,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> C6
		);	
			
	-- Third cathode mux
	CMUX5		:	Four_to_One_MUX port map 
		(
			A	=> CA5,
			B	=> CB5,
			C	=> CC5,
			D	=> CD5,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> C5
		);	

	-- Fourth cathode mux
	CMUX4		:	Four_to_One_MUX port map 
		(
			A	=> CA4,
			B	=> CB4,
			C	=> CC4,
			D	=> CD4,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> C4
		);	

	-- Fifth cathode mux
	CMUX3		:	Four_to_One_MUX port map 
		(
			A	=> CA3,
			B	=> CB3,
			C	=> CC3,
			D	=> CD3,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> C3
		);

	-- Sixth cathode mux
	CMUX2		:	Four_to_One_MUX port map 
		(
			A	=> CA2,
			B	=> CB2,
			C	=> CC2,
			D	=> CD2,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> C2
		);	

	-- Seventh cathode mux
	CMUX1		:	Four_to_One_MUX port map 
		(
			A	=> CA1,
			B	=> CB1,
			C	=> CC1,
			D	=> CD1,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> C1
		);	

	-- Eighth cathode mux
	CMUX0		:	Four_to_One_MUX port map 
		(
			A	=> CA0,
			B	=> CB0,
			C	=> CC0,
			D	=> CD0,
			
			S1	=> S1,
			S0	=> S0,
			
			M	=> C0
		);		
		
			
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	-- NOTHING HERE 
 			 
end LED_Driver_a; -- .same name as the architecture