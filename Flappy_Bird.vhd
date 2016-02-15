------------ HEADER ------------------------------------------------------------------------------------------------- 
-- Date				: April 10, 2015
-- Lab # and name	: Final Project - Flappy Bird
-- Student 1		: Qaleb Rush
-- Student 3		: Jerett Johnpebble

-- Description		: Top-Level circuit for Flappy Bird game.


-- Changes 
-- 			- Original

-- Formatting		: Edited using Xilinx ISE 13.2 or higher --> Open this file in ISE to properly view formatting

------------- END HEADER ------------------------------------------------------------------------------------------


-- Library Declarations 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------

-- Entity 

entity Flappy_Bird is port
	( 
		clk		:	in		std_logic; -- Clock input
		rst		:	in		std_logic; -- Reset input
		
		Button	:	in		std_logic; -- Jump input (preferably a button)
		Switch0	:	in		std_logic; -- Fast mode (preferably a switch)
		Switch1	:	in		std_logic; -- Hard mode (preferably a switch)
		Switch2	:	in		std_logic; -- Pause Switch (most preferably a switch)
		Switch3	:	in		std_logic; -- LED Flip Switch (most definitely preferably a switch)
		Switch4	:	in		std_logic; -- LED Rotate Switch (90 degrees clockwise)
		Switch5 	: 	in		std_logic; -- High Score Switch
		
		LA7		:	out	std_logic; -- LED Anode 7
		LA6		:	out	std_logic; -- LED Anode 6
		LA5		:	out	std_logic; -- LED Anode 5
		LA4		:	out	std_logic; -- LED Anode 4
		LA3		:	out	std_logic; -- LED Anode 3
		LA2		:	out	std_logic; -- LED Anode 2
		LA1		:	out	std_logic; -- LED Anode 1
		LA0		:	out	std_logic; -- LED Anode 0
		
		LC7		:	out	std_logic; -- LED Cathode 7
		LC6		:	out	std_logic; -- LED Cathode 6
		LC5		:	out	std_logic; -- LED Cathode 5
		LC4		:	out	std_logic; -- LED Cathode 4
		LC3		:	out	std_logic; -- LED Cathode 3
		LC2		:	out	std_logic; -- LED Cathode 2
		LC1		:	out	std_logic; -- LED Cathode 1
		LC0		:	out	std_logic; -- LED Cathode 0
		
		SA3		:	out	std_logic; -- Seven-Segment Anode 3
		SA2		:	out	std_logic; -- Seven-Segment Anode 2
		SA1		:	out	std_logic; -- Seven-Segment Anode 1
		SA0		:	out	std_logic; -- Seven-Segment Anode 0
		
		SCA		:	out	std_logic; -- Seven_Segment Cathode A
		SCB		:	out	std_logic; -- Seven_Segment Cathode B
		SCC		:	out	std_logic; -- Seven_Segment Cathode C
		SCD		:	out	std_logic; -- Seven_Segment Cathode D
		SCE		:	out	std_logic; -- Seven_Segment Cathode E
		SCF		:	out	std_logic; -- Seven_Segment Cathode F
		SCG		:	out	std_logic  -- Seven_Segment Cathode G
	);
end Flappy_Bird;
----------------------------------------------------------------------

-- Architecture 
architecture Flappy_Bird_a of Flappy_Bird is
----------------------------------------------------------------------

	--------------------------------------------------------
	-- Component Declarations 
	-------------------------------------------------------

	component Button_Input is port
		( 
			b		: 	in		std_logic;	-- button input
			clk	:	in		std_logic;	-- clock input
			en		:	in		std_logic;	-- enable input
			rst	:	in		std_logic;	-- reset input 
			
			Press	:	out	std_logic	-- button pressed output
		);
	end component;
	
	component Game is port
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
	end component;
	
	component Hex_Counter is port
		( 
			count			:	in		std_logic; -- Count input 	- Tells the counter to increment number
			clk			:	in		std_logic; -- Clock input 	- Used to control the DFFs
			rst			:	in		std_logic; -- Reset input 	- Used to reset the number to 0.
			en				:	in		std_logic;
				
			B3				:	out	std_logic; -- Output bit 	- Most significant
			B2				:	out	std_logic; -- Output bit
			B1				:	out	std_logic; -- Output bit
			B0				:	out	std_logic; -- Output bit 	- Least significant
			
			Increment	:	out	std_logic  -- Increment the next digit by 1
		);
	end component;
	
	component LED_Driver is port
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
	end component;
	
	component Seven_Segment_Display is port
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
	end component;
	
	component slow_enabler is port
		(
			clk : in  STD_LOGIC;
			Sen: out STD_LOGIC
		);
	end component;
	
	component enabler is port
		(
			clk : in  STD_LOGIC;
			Sen: out STD_LOGIC
		);
	end component;
	
	component fast_enabler is port
		(
			clk : in  STD_LOGIC;
			Sen: out STD_LOGIC
		);
	end component;
	
	component dff270 is port
		(
			 clk 		: in std_logic ;
			 clken	: in std_logic ;
			 rst 		: in std_logic ;
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
	
	component High_Score_Keeper is port
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
	end component;
	-------------------------------------------------------
	-- Internal Signal Declarations
	-------------------------------------------------------
	
	-- Input Processing
	signal Jump				:	std_logic; -- Jump signal
	signal Game_Pause		:	std_logic; -- Game pause signal
	
	signal Slow_Enable	:	std_logic; -- Slow enable signal
	signal Regular_Enable:	std_logic; -- Regular enable signal
	signal Fast_Enable	:	std_logic; -- Fast enable signal
	signal Game_Enable	:	std_logic; -- Game enable signal
	--
	
	-- Digits
	signal D3B3				:	std_logic; -- First digit first bit
	signal D3B2				:	std_logic; -- First digit second bit
	signal D3B1				:	std_logic; -- First digit third bit
	signal D3B0				:	std_logic; -- First digit fourth bit
	
	signal D2B3				:	std_logic; -- Second digit first bit
	signal D2B2				:	std_logic; -- Second digit second bit
	signal D2B1				:	std_logic; -- Second digit third bit
	signal D2B0				:	std_logic; -- Second digit fourth bit
	
	signal D1B3				:	std_logic; -- Third digit first bit
	signal D1B2				:	std_logic; -- Third digit second bit
	signal D1B1				:	std_logic; -- Third digit third bit
	signal D1B0				:	std_logic; -- Third digit fourth bit
	
	signal D0B3				:	std_logic; -- Fourth digit first bit
	signal D0B2				:	std_logic; -- Fourth digit second bit
	signal D0B1				:	std_logic; -- Fourth digit third bit
	signal D0B0				:	std_logic; -- Fourth digit fourth bit
	
	signal I3				:	std_logic; -- Increment first digit
	signal I2				:	std_logic; -- Increment second digit
	signal I1				:	std_logic; -- Increment third digit
	--
	
	-- High Score Digits
	signal H3B3				:	std_logic; -- First digit first bit
	signal H3B2				:	std_logic; -- First digit second bit
	signal H3B1				:	std_logic; -- First digit third bit
	signal H3B0				:	std_logic; -- First digit fourth bit
	
	signal H2B3				:	std_logic; -- Second digit first bit
	signal H2B2				:	std_logic; -- Second digit second bit
	signal H2B1				:	std_logic; -- Second digit third bit
	signal H2B0				:	std_logic; -- Second digit fourth bit
	
	signal H1B3				:	std_logic; -- Third digit first bit
	signal H1B2				:	std_logic; -- Third digit second bit
	signal H1B1				:	std_logic; -- Third digit third bit
	signal H1B0				:	std_logic; -- Third digit fourth bit
	
	signal H0B3				:	std_logic; -- Fourth digit first bit
	signal H0B2				:	std_logic; -- Fourth digit second bit
	signal H0B1				:	std_logic; -- Fourth digit third bit
	signal H0B0				:	std_logic; -- Fourth digit fourth bit
	--
	
	-- Game Outputs
	signal Score			:	std_logic; -- Score signal
	signal Lose				:	std_logic; -- Lose signal
	--
	
	-- LED Anodes and Cathodes
	signal AA7				:	std_logic; -- First game object first anode
	signal AA6				:	std_logic; -- First game object second anode
	signal AA5				:	std_logic; -- First game object third anode
	signal AA4				:	std_logic; -- First game object fourth anode
	signal AA3				:	std_logic; -- First game object fifth anode
	signal AA2				:	std_logic; -- First game object sixth anode
	signal AA1				:	std_logic; -- First game object seventh anode
	signal AA0				:	std_logic; -- First game object eighth anode
	
	signal AB7				:	std_logic; -- Second game object first anode
	signal AB6				:	std_logic; -- Second game object second anode
	signal AB5				:	std_logic; -- Second game object third anode
	signal AB4				:	std_logic; -- Second game object fourth anode
	signal AB3				:	std_logic; -- Second game object fifth anode
	signal AB2				:	std_logic; -- Second game object sixth anode
	signal AB1				:	std_logic; -- Second game object seventh anode
	signal AB0				:	std_logic; -- Second game object eighth anode
	
	signal AC7				:	std_logic; -- Third game object first anode
	signal AC6				:	std_logic; -- Third game object second anode
	signal AC5				:	std_logic; -- Third game object third anode
	signal AC4				:	std_logic; -- Third game object fourth anode
	signal AC3				:	std_logic; -- Third game object fifth anode
	signal AC2				:	std_logic; -- Third game object sixth anode
	signal AC1				:	std_logic; -- Third game object seventh anode
	signal AC0				:	std_logic; -- Third game object eighth anode
	
	signal CA7				:	std_logic; -- First game object first cathode
	signal CA6				:	std_logic; -- First game object second cathode
	signal CA5				:	std_logic; -- First game object third cathode
	signal CA4				:	std_logic; -- First game object fourth cathode
	signal CA3				:	std_logic; -- First game object fifth cathode
	signal CA2				:	std_logic; -- First game object sixth cathode
	signal CA1				:	std_logic; -- First game object seventh cathode
	signal CA0				:	std_logic; -- First game object eighth cathode
	          
	signal CB7				:	std_logic; -- Second game object first cathode
	signal CB6				:	std_logic; -- Second game object second cathode
	signal CB5				:	std_logic; -- Second game object third cathode
	signal CB4				:	std_logic; -- Second game object fourth cathode
	signal CB3				:	std_logic; -- Second game object fifth cathode
	signal CB2				:	std_logic; -- Second game object sixth cathode
	signal CB1				:	std_logic; -- Second game object seventh cathode
	signal CB0				:	std_logic; -- Second game object eighth cathode
	          
	signal CC7				:	std_logic; -- Third game object first cathode
	signal CC6				:	std_logic; -- Third game object second cathode
	signal CC5				:	std_logic; -- Third game object third cathode
	signal CC4				:	std_logic; -- Third game object fourth cathode
	signal CC3				:	std_logic; -- Third game object fifth cathode
	signal CC2				:	std_logic; -- Third game object sixth cathode
	signal CC1				:	std_logic; -- Third game object seventh cathode
	signal CC0				:	std_logic; -- Third game object eighth cathode
	--
	
	-- LED Driver output
	signal A7				:	std_logic; -- First LED Driver Anode output
	signal A6				:	std_logic; -- Second LED Driver Anode output
	signal A5				:	std_logic; -- Third LED Driver Anode output
	signal A4				:	std_logic; -- Four LED Driver Anode output
	signal A3				:	std_logic; -- Fifth LED Driver Anode output
	signal A2				:	std_logic; -- Sixth LED Driver Anode output
	signal A1				:	std_logic; -- Seventh LED Driver Anode output
	signal A0				:	std_logic; -- Eighth LED Driver Anode output
	
	signal C7				:	std_logic; -- First LED Driver Cathode output
	signal C6				:	std_logic; -- Second LED Driver Cathode output
	signal C5				:	std_logic; -- Third LED Driver Cathode output
	signal C4				:	std_logic; -- Four LED Driver Cathode output
	signal C3				:	std_logic; -- Fifth LED Driver Cathode output
	signal C2				:	std_logic; -- Sixth LED Driver Cathode output
	signal C1				:	std_logic; -- Seventh LED Driver Cathode output
	signal C0				:	std_logic; -- Eighth LED Driver Cathode output
	--
	
	-- DFF output
	signal DFF_Q			:	std_logic; -- DFF output
	--
	
	-- 2 : 1 MUX output
	signal MUX_Enable		:	std_logic; -- MUX enable output
	
	signal MD3B3			: 	std_logic; -- Mux first digit first bit
	signal MD2B3			: 	std_logic; -- Mux second digit first bit
	signal MD1B3			: 	std_logic; -- Mux third digit first bit
	signal MD0B3			: 	std_logic; -- Mux fourth digit first bit
	
	signal MD3B2			: 	std_logic; -- Mux first digit second bit
	signal MD2B2			: 	std_logic; -- Mux second digit second bit
	signal MD1B2			: 	std_logic; -- Mux third digit second bit
	signal MD0B2			: 	std_logic; -- Mux fourth digit second bit
	
	signal MD3B1			: 	std_logic; -- Mux first digit third bit
	signal MD2B1			: 	std_logic; -- Mux second digit third bit
	signal MD1B1			: 	std_logic; -- Mux third digit third bit
	signal MD0B1			: 	std_logic; -- Mux fourth digit third bit
	
	signal MD3B0			: 	std_logic; -- Mux first digit fourth bit
	signal MD2B0			: 	std_logic; -- Mux second digit fourth bit
	signal MD1B0			: 	std_logic; -- Mux third digit fourth bit
	signal MD0B0			: 	std_logic; -- Mux fourth digit fourth bit
	--
	
	-- 4 : 1 MUX outputs
	signal MA7				:	std_logic; -- First MUX output Anode
	signal MA6				:	std_logic; -- Second MUX output Anode
	signal MA5				:	std_logic; -- Third MUX output Anode
	signal MA4				:	std_logic; -- Fourth MUX output Anode
	signal MA3				:	std_logic; -- Fifth MUX output Anode
	signal MA2				:	std_logic; -- Sixth MUX output Anode
	signal MA1				:	std_logic; -- Seventh MUX output Anode
	signal MA0				:	std_logic; -- Eighth MUX output Anode
	
	signal MC7				:	std_logic; -- First MUX output Cathode
	signal MC6				:	std_logic; -- Second MUX output Cathode
	signal MC5				:	std_logic; -- Third MUX output Cathode
	signal MC4				:	std_logic; -- Fourth MUX output Cathode
	signal MC3				:	std_logic; -- Fifth MUX output Cathode
	signal MC2				:	std_logic; -- Sixth MUX output Cathode
	signal MC1				:	std_logic; -- Seventh MUX output Cathode
	signal MC0				:	std_logic; -- Eighth MUX output Cathode
	--
	 
	-- High Score output bit
	signal Greater			:	std_logic; -- 
	

begin
	
	-------------------------------------------------------
	-- Component Instantiations
	-------------------------------------------------------

	-- Button Handler to handle the button input
	BUTTON_HANDLER : Button_Input port map
		(
			b			=> Button,
			clk		=> clk,
			en			=> Fast_Enable,
			rst		=> rst,
			 
			Press	 	=> Jump
		);
		
	-- Slow enabler for the game
	SLOW : slow_enabler port map
		(
			clk		=> clk,
			Sen 	 	=> Slow_Enable
		);
	
	-- Regular enabler for the game
	REGULAR : enabler port map
		(
			clk		=> clk,
			Sen		=> Regular_Enable
		);
	
	-- Enabler for everything else
	FAST : fast_enabler port map
		(
			clk		=> clk,
			Sen 	 	=> Fast_Enable
		);
		
	-- Field to render and process the funtastic game of Stupid Squirrel
	Field : Game port map
		(
			clk	 => clk,
			rst	 => rst,
			en		 => Game_Enable,
			 
			Jump	 => Jump,
			Hard	 => Switch1,
			 
			Score	 => Score,
			Lose	 => Lose,
			 
			AA7	 => AA7,
			AA6	 => AA6,
			AA5	 => AA5,
			AA4	 => AA4,
			AA3	 => AA3,
			AA2	 => AA2,
			AA1	 => AA1,
			AA0	 => AA0,
			           
			BA7	 => AB7,
			BA6	 => AB6,
			BA5	 => AB5,
			BA4	 => AB4,
			BA3	 => AB3,
			BA2	 => AB2,
			BA1	 => AB1,
			BA0	 => AB0,
			           
			CA7	 => AC7,
			CA6	 => AC6,
			CA5	 => AC5,
			CA4	 => AC4,
			CA3	 => AC3,
			CA2	 => AC2,
			CA1	 => AC1,
			CA0	 => AC0,
			           
			AC7	 => CA7,
			AC6	 => CA6,
			AC5	 => CA5,
			AC4	 => CA4,
			AC3	 => CA3,
			AC2	 => CA2,
			AC1	 => CA1,
			AC0	 => CA0,
			           
			BC7	 => CB7,
			BC6	 => CB6,
			BC5	 => CB5,
			BC4	 => CB4,
			BC3	 => CB3,
			BC2	 => CB2,
			BC1	 => CB1,
			BC0	 => CB0,
			           
			CC7	 => CC7,
			CC6	 => CC6,
			CC5	 => CC5,
			CC4	 => CC4,
			CC3	 => CC3,
			CC2	 => CC2,
			CC1	 => CC1,
			CC0	 => CC0
		);
		
	-- Driver to display the game on the LED matrix.
	LED : LED_Driver port map
		(
			clk	 => clk,
			rst	 => rst,
			en 	 => Fast_Enable,
			 
			AA7	 => AA7,
			AA6	 => AA6,
			AA5	 => AA5,
			AA4	 => AA4,
			AA3	 => AA3,
			AA2	 => AA2,
			AA1	 => AA1,
			AA0	 => AA0,
			           
			AB7	 => AB7,
			AB6	 => AB6,
			AB5	 => AB5,
			AB4	 => AB4,
			AB3	 => AB3,
			AB2	 => AB2,
			AB1	 => AB1,
			AB0	 => AB0,
			           
			AC7	 => AA7,
			AC6	 => AA6,
			AC5	 => AA5,
			AC4	 => AA4,
			AC3	 => AA3,
			AC2	 => AA2,
			AC1	 => AA1,
			AC0	 => AA0,
			           
			AD7	 => AC7,
			AD6	 => AC6,
			AD5	 => AC5,
			AD4	 => AC4,
			AD3	 => AC3,
			AD2	 => AC2,
			AD1	 => AC1,
			AD0	 => AC0,
			           
			CA7	 => CA7,
			CA6	 => CA6,
			CA5	 => CA5,
			CA4	 => CA4,
			CA3	 => CA3,
			CA2	 => CA2,
			CA1	 => CA1,
			CA0	 => CA0,
			           
			CB7	 => CB7,
			CB6	 => CB6,
			CB5	 => CB5,
			CB4	 => CB4,
			CB3	 => CB3,
			CB2	 => CB2,
			CB1	 => CB1,
			CB0	 => CB0,
			           
			CC7	 => CA7,
			CC6	 => CA6,
			CC5	 => CA5,
			CC4	 => CA4,
			CC3	 => CA3,
			CC2	 => CA2,
			CC1	 => CA1,
			CC0	 => CA0,
			           
			CD7	 => CC7,
			CD6	 => CC6,
			CD5	 => CC5,
			CD4	 => CC4,
			CD3	 => CC3,
			CD2	 => CC2,
			CD1	 => CC1,
			CD0	 => CC0,
			 
			A7		 => A7,
			A6		 => A6,
			A5		 => A5,
			A4		 => A4,
			A3		 => A3,
			A2		 => A2,
			A1		 => A1,
			A0		 => A0,
				       
			C7		 => C7,
			C6		 => C6,
			C5		 => C5,
			C4		 => C4,
			C3		 => C3,
			C2		 => C2,
			C1		 => C1,
			C0		 => C0
		);
		
	-- Counter for the first digit
	COUNT3 : Hex_Counter port map
		(
			count		 => I3,
			clk		 => clk,
			rst		 => rst,
			en			 => Game_Enable,
				 
			B3			 => D3B3,
			B2			 => D3B2,
			B1			 => D3B1,
			B0			 => D3B0,
			 
			Increment => open
		);
		
	-- Counter for the second digit
	COUNT2 : Hex_Counter port map
		(
			count		 => I2,
			clk		 => clk,
			rst		 => rst,
			en			 => Game_Enable,
				 
			B3			 => D2B3,
			B2			 => D2B2,
			B1			 => D2B1,
			B0			 => D2B0,
			 
			Increment => I3
		);
		
	-- Counter for the third digit
	COUNT1 : Hex_Counter port map
		(
			count		 => I1,
			clk		 => clk,
			rst		 => rst,
			en			 => Game_Enable,
				 
			B3			 => D1B3,
			B2			 => D1B2,
			B1			 => D1B1,
			B0			 => D1B0,
			 
			Increment => I2
		);
		
	-- Counter for the fourth digit
	COUNT0 : Hex_Counter port map
		(
			count		 => Score,
			clk		 => clk,
			rst		 => rst,
			en			 => Game_Enable,
				 
			B3			 => D0B3,
			B2			 => D0B2,
			B1			 => D0B1,
			B0			 => D0B0,
			 
			Increment => I1
		);
		
	-- Seven Segment Display drive to output the score to the seven-segment display
	Seven_Segment : Seven_Segment_Display port map
		(
			clk => clk,
			en	 => Fast_Enable,
			rst => rst,
			 
			A3	 => MD3B3,
			A2	 => MD3B2,
			A1	 => MD3B1,
			A0	 => MD3B0,
			 
			B3	 => MD2B3,
			B2	 => MD2B2,
			B1	 => MD2B1,
			B0	 => MD2B0,
			 
			C3	 => MD1B3,
			C2	 => MD1B2,
			C1	 => MD1B1,
			C0	 => MD1B0,
			 
			D3	 => MD0B3,
			D2	 => MD0B2,
			D1	 => MD0B1,
			D0	 => MD0B0,
			 
			AN3 => SA3,
			AN2 => SA2,
			AN1 => SA1,
			AN0 => SA0,
			       
			CA	 => SCA,
			CB	 => SCB,
			CC	 => SCC,
			CD	 => SCD,
			CE	 => SCE,
			CF	 => SCF,
			CG	 => SCG	
		);
		
	-- DFF to store the lose signal
	LOSE_STORE : dff270 port map
	(
		 clk 		=>	clk,
		 clken	=>	Fast_Enable,
		 rst 		=>	rst,
		 d 		=>	Lose,
		 q 		=>	DFF_Q
	 );
	 
	 -- MUX to determine the enabler to be used for the field
	 MUX : Multiplexer port map
	 	( 
	 		A	=> Regular_Enable,
	 		B	=> Slow_Enable,	
	 		S	=> Switch0,	
	 		
	 		M	=> MUX_Enable	
	 	);
		
	-- MUX to determine the first Anode
	AMUX7 : Four_to_One_MUX port map
		(
			A	=> C7,
			B	=>	C7,
			C	=>	A7,
			D	=>	A7,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MA7
		);
		
	-- MUX to determine the second Anode
	AMUX6 : Four_to_One_MUX port map
		(
			A	=> C6,
			B	=>	C6,
			C	=>	A6,
			D	=>	A6,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MA6
		);
		
	-- MUX to determine the third Anode
	AMUX5 : Four_to_One_MUX port map
		(
			A	=> C5,
			B	=>	C5,
			C	=>	A5,
			D	=>	A5,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MA5
		);
		
	-- MUX to determine the fourth Anode
	AMUX4 : Four_to_One_MUX port map
		(
			A	=> C4,
			B	=>	C4,
			C	=>	A4,
			D	=>	A4,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MA4
		);
		
	-- MUX to determine the fifth Anode
	AMUX3 : Four_to_One_MUX port map
		(
			A	=> C3,
			B	=>	C3,
			C	=>	A3,
			D	=>	A3,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MA3
		);
		
	-- MUX to determine the sixth Anode
	AMUX2 : Four_to_One_MUX port map
		(
			A	=> C2,
			B	=>	C2,
			C	=>	A2,
			D	=>	A2,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MA2
		);
		
	-- MUX to determine the seventh Anode
	AMUX1 : Four_to_One_MUX port map
		(
			A	=> C1,
			B	=>	C1,
			C	=>	A1,
			D	=>	A1,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MA1
		);
		
	-- MUX to determine the eighth Anode
	AMUX0 : Four_to_One_MUX port map
		(
			A	=> C0,
			B	=>	C0,
			C	=>	A0,
			D	=>	A0,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MA0
		);
		
	-- MUX to determine the first Anode
	CMUX7 : Four_to_One_MUX port map
		(
			A	=> A0,
			B	=>	A7,
			C	=>	C0,
			D	=>	C7,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MC7
		);
		
	-- MUX to determine the second Anode
	CMUX6 : Four_to_One_MUX port map
		(
			A	=> A1,
			B	=>	A6,
			C	=>	C1,
			D	=>	C6,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MC6
		);
		
	-- MUX to determine the third Anode
	CMUX5 : Four_to_One_MUX port map
		(
			A	=> A2,
			B	=>	A5,
			C	=>	C2,
			D	=>	C5,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MC5
		);
		
	-- MUX to determine the fourth Anode
	CMUX4 : Four_to_One_MUX port map
		(
			A	=> A3,
			B	=>	A4,
			C	=>	C3,
			D	=>	C4,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MC4
		);
		
	-- MUX to determine the fifth Anode
	CMUX3 : Four_to_One_MUX port map
		(
			A	=> A4,
			B	=>	A3,
			C	=>	C4,
			D	=>	C3,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MC3
		);
		
	-- MUX to determine the sixth Anode
	CMUX2 : Four_to_One_MUX port map
		(
			A	=> A5,
			B	=>	A2,
			C	=>	C5,
			D	=>	C2,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MC2
		);
		
	-- MUX to determine the seventh Anode
	CMUX1 : Four_to_One_MUX port map
		(
			A	=> A6,
			B	=>	A1,
			C	=>	C6,
			D	=>	C1,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MC1
		);
		
	-- MUX to determine the eighth Anode
	CMUX0 : Four_to_One_MUX port map
		(
			A	=> A7,
			B	=>	A0,
			C	=>	C7,
			D	=>	C0,
			
			S1	=>	Switch4,
			S0	=> Switch3,
			
			M	=> MC0
		);
	
	-- Highest bit High Score Keeper 
	Score3	:	High_Score_Keeper port map
	(
		clk	=> clk,	
	   en		=> Game_Enable,	
	   rst	=> '0',	
			
		B15	=> D3B3,	
	   B14	=> D3B2,	
	   B13	=> D3B1,	
	   B12	=> D3B0,	
		B11	=> D2B3,	
	   B10	=> D2B2,	
	   B9		=> D2B1,	
	   B8 	=> D2B0,	
		B7		=> D1B3,	
	   B6		=> D1B2,	
	   B5		=> D1B1,	
	   B4 	=> D1B0,	
	   B3		=> D0B3,	
	   B2		=> D0B2,	
	   B1		=> D0B1,	
	   B0 	=> D0B0,	
			
		H15 	=> H3B3,
	   H14 	=> H3B2,
	   H13 	=> H3B1,
	   H12 	=> H3B0,
		H11	=> H2B3,
		H10   => H2B2,
		H9	   => H2B1,
		H8    => H2B0,
		H7		=> H1B3,
		H6	   => H1B2,
		H5	   => H1B1,
		H4    => H1B0,
		H3		=> H0B3,
		H2	   => H0B2,
		H1	   => H0B1,
		H0    => H0B0
	);	
	
	 -- Score Mux first digit first bit
	 Score_Mux_D3B3 : Multiplexer port map
	 	( 
	 		A	=> H3B3,
	 		B	=> D3B3,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD3B3	
	 	);
		
		 -- Score Mux first digit second bit
	 Score_Mux_D3B2 : Multiplexer port map
	 	( 
	 		A	=> H3B2,
	 		B	=> D3B2,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD3B2	
	 	);
		
		 -- Score Mux first digit third bit
	 Score_Mux_D3B1 : Multiplexer port map
	 	( 
	 		A	=> H3B1,
	 		B	=> D3B1,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD3B1	
	 	);
		
		 -- Score Mux first digit fourth bit
	 Score_Mux_D3B0 : Multiplexer port map
	 	( 
	 		A	=> H3B0,
	 		B	=> D3B0,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD3B0	
	 	);
		
		-- Score Mux second digit first bit
	 Score_Mux_D2B3 : Multiplexer port map
	 	( 
	 		A	=> H2B3,
	 		B	=> D2B3,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD2B3	
	 	);
		
		 -- Score Mux second digit second bit
	 Score_Mux_D2B2 : Multiplexer port map
	 	( 
	 		A	=> H2B2,
	 		B	=> D2B2,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD2B2	
	 	);
		
		 -- Score Mux second digit third bit
	 Score_Mux_D2B1 : Multiplexer port map
	 	( 
	 		A	=> H2B1,
	 		B	=> D2B1,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD2B1	
	 	);
		
		 -- Score Mux second digit fourth bit
	 Score_Mux_D2B0 : Multiplexer port map
	 	( 
	 		A	=> H2B0,
	 		B	=> D2B0,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD2B0	
	 	);
		
		-- Score Mux third digit first bit
	 Score_Mux_D1B3 : Multiplexer port map
	 	( 
	 		A	=> H1B3,
	 		B	=> D1B3,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD1B3	
	 	);
		
		 -- Score Mux third digit second bit
	 Score_Mux_D1B2 : Multiplexer port map
	 	( 
	 		A	=> H1B2,
	 		B	=> D1B2,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD1B2	
	 	);
		
		 -- Score Mux third digit third bit
	 Score_Mux_D1B1 : Multiplexer port map
	 	( 
	 		A	=> H1B1,
	 		B	=> D1B1,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD1B1	
	 	);
		
		 -- Score Mux third digit fourth bit
	 Score_Mux_D1B0 : Multiplexer port map
	 	( 
	 		A	=> H1B0,
	 		B	=> D1B0,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD1B0	
	 	);
		
		-- Score Mux fourth digit first bit
	 Score_Mux_D0B3 : Multiplexer port map
	 	( 
	 		A	=> H0B3,
	 		B	=> D0B3,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD0B3	
	 	);
		
		 -- Score Mux fourth digit second bit
	 Score_Mux_D0B2 : Multiplexer port map
	 	( 
	 		A	=> H0B2,
	 		B	=> D0B2,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD0B2	
	 	);
		
		 -- Score Mux fourth digit third bit
	 Score_Mux_D0B1 : Multiplexer port map
	 	( 
	 		A	=> H0B1,
	 		B	=> D0B1,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD0B1	
	 	);
		
		 -- Score Mux fourth digit fourth bit
	 Score_Mux_D0B0 : Multiplexer port map
	 	( 
	 		A	=> H0B0,
	 		B	=> D0B0,	
	 		S	=> Switch5,	
	 		
	 		M	=> MD0B0	
	 	);
		
		
	-------------------------------------------------------------
	-- Begin Design Description of Gates and how to connect them
	-------------------------------------------------------------
	
	Game_Pause 	<= Switch2 OR DFF_Q;
	Game_Enable <= MUX_Enable AND NOT Game_Pause;
	
	LA7 <= MA7;
	LA6 <= MA6;
	LA5 <= MA5;
	LA4 <= MA4;
	LA3 <= MA3;
	LA2 <= MA2;
	LA1 <= MA1;
	LA0 <= MA0;
	       
	LC7 <= MC7;
	LC6 <= MC6;
	LC5 <= MC5;
	LC4 <= MC4;
	LC3 <= MC3;
	LC2 <= MC2;
	LC1 <= MC1;
	LC0 <= MC0;
		 
end Flappy_Bird_a; -- .same name as the architecture