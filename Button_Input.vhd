------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: 4/13/2015
-- Lab # and name	: Lab 9 Flappy Bird
-- Student 1		: Jerett Johnstone
-- Student 2		: Caleb Rush

-- Description		: Button Input component to input when button is pressed


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Button_Input is port
	( 
		b		: 	in		std_logic;	-- button input
		clk	:	in		std_logic;	-- clock input
		en		:	in		std_logic;	-- enable input
		rst	:	in		std_logic;	-- reset input 
		
		Press	:	out	std_logic	-- button pressed output
	);
end Button_Input;
----------------------------------------------------------------------

-- Architecture 
architecture Button_Input_a of Button_Input is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	component dff270 is port
		(
			clk 	: in std_logic ;
			clken	: in std_logic ;
			rst 	: in std_logic ;
			d 		: in std_logic ;
			q 		: out std_logic
		);
	end component;
	
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	signal P1	:	std_logic; -- first present state 
	signal P0	:	std_logic; -- second present state 
	signal N1 	: 	std_logic; -- first next state 
	signal N0 	:	std_logic; -- second next state 

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------
	--	DFF for the first state 
	DFF1 : dff270  port map
		(
			clk 	=>	clk	,
			clken	=>	en		,
			rst 	=>	rst	,
			d 		=>	N1		,
			q 		=>	P1		
		);
	-- DFF for the second state 	
	DFF0 : dff270  port map
		(
			clk 	=>	clk	,
			clken	=>	en		,
			rst 	=>	rst	,
			d 		=>	N0		,
			q 		=>	P0	
		);
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	N1	<= NOT P0 AND b;
	N0 <= P1 OR b;
	Press <= P1 AND P0;
		 
end Button_Input_a; -- .same name as the architecture