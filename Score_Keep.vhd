------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 20, 2015
-- Lab # and name	: Project Flappy Bird
-- Student 1		: Qaleb Rush
-- Student 3		: Jerett Johnstone

-- Description		: High Score Keeper  


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------

--

-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity High_Score_Keeper is port
	( 
		clk	: in 	std_logic		;	-- clock input
		en		: in	std_logic		;	-- enable input
		rst	: in  std_logic		;	-- reset input
	
		B15		: in 	std_logic		; 	-- First bit input 	
		B14		: in 	std_logic		; 	-- Second bit input 	
		B13		: in 	std_logic		; 	-- Third bit input 			
		B12 		: in 	std_logic		; 	-- Fourth bit input 	
		B11		: in 	std_logic		; 	-- First bit input 	
		B10		: in 	std_logic		; 	-- Second bit input 	
		B9			: in 	std_logic		; 	-- Third bit input 			
		B8 		: in 	std_logic		; 	-- Fourth bit input 
		B7			: in 	std_logic		; 	-- First bit input 	
		B6			: in 	std_logic		; 	-- Second bit input 	
		B5			: in 	std_logic		; 	-- Third bit input 			
		B4 		: in 	std_logic		; 	-- Fourth bit input 	
		B3			: in 	std_logic		; 	-- First bit input 	
		B2			: in 	std_logic		; 	-- Second bit input 	
		B1			: in 	std_logic		; 	-- Third bit input 			
		B0 		: in 	std_logic		; 	-- Fourth bit input
		
		H15		: out 	std_logic		; 	-- First bit input 	
		H14		: out 	std_logic		; 	-- Second bit input 	
		H13		: out 	std_logic		; 	-- Third bit input 			
		H12 		: out 	std_logic		; 	-- Fourth bit input 	
		H11		: out 	std_logic		; 	-- First bit input 	
		H10		: out 	std_logic		; 	-- Second bit input 	
		H9			: out 	std_logic		; 	-- Third bit input 			
		H8 		: out 	std_logic		; 	-- Fourth bit input 
		H7			: out 	std_logic		; 	-- First bit input 	
		H6			: out 	std_logic		; 	-- Second bit input 	
		H5			: out 	std_logic		; 	-- Third bit input 			
		H4 		: out 	std_logic		; 	-- Fourth bit input 	
		H3			: out 	std_logic		; 	-- First bit input 	
		H2			: out 	std_logic		; 	-- Second bit input 	
		H1			: out 	std_logic		; 	-- Third bit input 			
		H0 		: out 	std_logic		 	-- Fourth bit input
	);
end High_Score_Keeper;
----------------------------------------------------------------------

-- Architecture 
architecture High_Score_Keeper_a of High_Score_Keeper is
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

component Comparator is port
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
	
	signal 	M15		:	std_logic;	-- Mux1 output
	signal 	M14		:	std_logic;	-- Mux2 output
	signal 	M13		:	std_logic;	-- Mux3 output
	signal 	M12		:	std_logic;	-- Mux4 output
	signal 	M11		:	std_logic;	-- Mux1 output
	signal 	M10		:	std_logic;	-- Mux2 output
	signal 	M9			:	std_logic;	-- Mux3 output
	signal 	M8 		:	std_logic;	-- Mux4 output
	signal 	M7			:	std_logic;	-- Mux1 output
	signal 	M6			:	std_logic;	-- Mux2 output
	signal 	M5			:	std_logic;	-- Mux3 output
	signal 	M4 		:	std_logic;	-- Mux4 output
	signal 	M3			:	std_logic;	-- Mux1 output
	signal 	M2			:	std_logic;	-- Mux2 output
	signal 	M1			:	std_logic;	-- Mux3 output
	signal 	M0 		:	std_logic;	-- Mux4 output
	
	signal 	Q15		:	std_logic;	-- DFF1 output
	signal 	Q14		:	std_logic;	-- DFF2 output
	signal 	Q13		:	std_logic;	-- DFF3 output
	signal 	Q12		:	std_logic;	-- DFF4 output
	signal 	Q11		:	std_logic;	-- DFF1 output
	signal 	Q10		:	std_logic;	-- DFF2 output
	signal 	Q9			:	std_logic;	-- DFF3 output
	signal 	Q8 		:	std_logic;	-- DFF4 output
	signal 	Q7			:	std_logic;	-- DFF1 output
	signal 	Q6			:	std_logic;	-- DFF2 output
	signal 	Q5			:	std_logic;	-- DFF3 output
	signal 	Q4 		:	std_logic;	-- DFF4 output
	signal 	Q3			:	std_logic;	-- DFF1 output
	signal 	Q2			:	std_logic;	-- DFF2 output
	signal 	Q1			:	std_logic;	-- DFF3 output
	signal 	Q0 		:	std_logic;	-- DFF4 output
	
	signal 	S3		:	std_logic;	-- Comparator output
	signal 	S2		:	std_logic;	-- Comparator output
	signal 	S1		:	std_logic;	-- Comparator output
	signal 	S0		:	std_logic;	-- Comparator output

	signal 	greater 	:	std_logic; -- Greatert signal

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- First Multiplexer 
   MUX15 :  Multiplexer port map 
	(
	   A	=> B15,	
		B	=> Q15	,
		S	=> greater	,
		
		M	=> M15	
	);
	
	-- Second Multiplexer 
   MUX14 :  Multiplexer port map 
	(
	   A	=> B14	,	
		B	=> Q14	,
		S	=> greater		,
		
		M	=> M14	
	);
	
	-- Third Multiplexer 
   MUX13 :  Multiplexer port map 
	(
	   A	=> B13	,	
		B	=> Q13	,
		S	=> greater,
		
		M	=> M13	
	);
	
	-- Fourth Multiplexer 
   MUX12 :  Multiplexer port map 
	(
	   A	=> B12	,	
		B	=> Q12	,
		S	=> greater	,
		
		M	=> M12	
	);
	
	-- Fourth Multiplexer 
   MUX11 :  Multiplexer port map 
	(
	   A	=> B11	,	
		B	=> Q11	,
		S	=> greater,
		
		M	=> M11	
	);
	
	-- First Multiplexer 
   MUX10 :  Multiplexer port map 
	(
	   A	=> B10	,	
		B	=> Q10	,
		S	=> greater	,
		
		M	=> M10	
	);
	
	-- Second Multiplexer 
   MUX9 :  Multiplexer port map 
	(
	   A	=> B9	,	
		B	=> Q9	,
		S	=> greater	,
		
		M	=> M9	
	);
	
	-- Third Multiplexer 
   MUX8 :  Multiplexer port map 
	(
	   A	=> B8	,	
		B	=> Q8	,
		S	=> greater ,
		
		M	=> M8	
	);
	
	-- Fourth Multiplexer 
   MUX7 :  Multiplexer port map 
	(
	   A	=> B7	,	
		B	=> Q7	,
		S	=> greater	,
		
		M	=> M7	
	);
	
	
	-- First Multiplexer 
   MUX6 :  Multiplexer port map 
	(
	   A	=> B6	,	
		B	=> Q6	,
		S	=> greater	,
		
		M	=> M6	
	);
	
	-- Second Multiplexer 
   MUX5 :  Multiplexer port map 
	(
	   A	=> B5	,	
		B	=> Q5	,
		S	=> greater	,
		
		M	=> M5	
	);
	
	-- Third Multiplexer 
   MUX4 :  Multiplexer port map 
	(
	   A	=> B4	,	
		B	=> Q4	,
		S	=> greater	,
		
		M	=> M4	
	);
	
	-- Fourth Multiplexer 
   MUX3 :  Multiplexer port map 
	(
	   A	=> B3	,	
		B	=> Q3	,
		S	=> greater	,
		
		M	=> M3	
	);
	
	
	-- First Multiplexer 
   MUX2 :  Multiplexer port map 
	(
	   A	=> B2	,	
		B	=> Q2	,
		S	=> greater	,
		
		M	=> M2	
	);
	
	-- Second Multiplexer 
   MUX1 :  Multiplexer port map 
	(
	   A	=> B1	,	
		B	=> Q1	,
		S	=> greater	,
		
		M	=> M1	
	);
	
	-- Third Multiplexer 
   MUX0 :  Multiplexer port map 
	(
	   A	=> B0	,	
		B	=> Q0	,
		S	=> greater	,
		
		M	=> M0	
	);
	
	-- First DFF 
	Flippy15	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M15 	,
		q 		 => Q15

	);
	
	-- Second DFF 
	Flippy14	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M14,
		q 		 => Q14

	);
	
	-- Third DFF 
	Flippy13	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M13,
		q 		 => Q13

	);
	
	-- Fourth DFF 
	Flippy12	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M12,
		q 		 => Q12
	);	
		-- First DFF 
	Flippy11	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M11,
		q 		 => Q11

	);
	
	-- Second DFF 
	Flippy10	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M10,
		q 		 => Q10

	);
	
	-- Third DFF 
	Flippy9	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M9,
		q 		 => Q9

	);
	
	-- Fourth DFF 
	Flippy8	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M8,
		q 		 => Q8
	);

-- First DFF 
	Flippy7	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M7	,
		q 		 => Q7

	);
	
	-- Second DFF 
	Flippy6	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M6,
		q 		 => Q6

	);
	
	-- Third DFF 
	Flippy5	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M5,
		q 		 => Q5

	);
	
	-- Fourth DFF 
	Flippy4	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M4,
		q 		 => Q4
	);

-- First DFF 
	Flippy3	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M3,
		q 		 => Q3

	);
	
	-- Second DFF 
	Flippy2	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M2,
		q 		 => Q2

	);
	
	-- Third DFF 
	Flippy1	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M1,
		q 		 => Q1

	);
	
	-- Fourth DFF 
	Flippy0	:	dff270 port map 
	(
		clk 	 => clk	,
		clken	 => en	,
		rst 	 => rst	,
		d 		 => M0,
		q 		 => Q0


	);
	
	-- Highest bit comparator
	Compare3 	:	Comparator port map
	(
		A3			=> Q15,
		A2			=> Q14,
		A1			=> Q13,
		A0			=> Q12,
				
		B3			=> B15,
		B2			=> B14,
		B1			=> B13,
		B0			=> B12,
	   
		Output	=> S3
	);
	
	--  Bit comparator
	Compare2 	:	Comparator port map
	(
		A3			=> Q11,
		A2			=> Q10,
		A1			=> Q9,
		A0			=> Q8,
				
		B3			=> B11,
		B2			=> B10,
		B1			=> B9,
		B0			=> B8,
	   
		Output	=> S2
	);
	
	--  Bit comparator
	Compare1 	:	Comparator port map
	(
		A3			=> Q7,
		A2			=> Q6,
		A1			=> Q5,
		A0			=> Q4,
				
		B3			=> B7,
		B2			=> B6,
		B1			=> B5,
		B0			=> B4,
	   
		Output	=> S1
	);
	
	-- Lowest bit comparator
	Compare0 	:	Comparator port map
	(
		A3			=> Q3,
		A2			=> Q2,
		A1			=> Q1,
		A0			=> Q0,
				
		B3			=> B3,
		B2			=> B2,
		B1			=> B1,
		B0			=> B0,
	   
		Output	=> S0
	);
	
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	greater <= S3 AND S2 AND S1 AND S0;
	
	H15 <= Q15	;
	H14 <= Q14	;
	H13 <= Q13	;
	H12 <= Q12	;
	H11 <= Q11	;
	H10 <= Q10	;
	H9	 <= Q9	;
	H8  <= Q8 	;
	H7	 <= Q7	;
	H6	 <= Q6	;
	H5	 <= Q5	;
	H4  <= Q4 	;
	H3	 <= Q3	;
	H2	 <= Q2	;
	H1	 <= Q1	;
	H0  <= Q0 	;
 			 
end High_Score_Keeper_a; -- .same name as the architecture