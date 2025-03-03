--------------------------------------------
-- Module Name: tutorial
--------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.numeric_std.ALL;
library UNISIM;
use UNISIM.VComponents.all;

	entity ALU is
	port (
		a : in STD_LOGIC_VECTOR(1 downto 0);
		b : in STD_LOGIC_VECTOR(1 downto 0);
		an : out STD_LOGIC_VECTOR(3 downto 0); 
	--	C : out STD_LOGIC_VECTOR(3 downto 0);
		seg : out STD_LOGIC_VECTOR(6 downto 0);
		OPCODE : in STD_LOGIC_VECTOR(1 downto 0)

	);
	end ALU;
	
Architecture behavior of ALU is
	Signal m_int : STD_LOGIC; 
	Signal u1_o : STD_LOGIC;
	signal TempResult : STD_LOGIC_VECTOR(7 downto 0);
	signal TempA, TempB : INTEGER range 0 to 15;   
    begin
    TempA <= to_integer(unsigned(a));
    TempB <= to_integer(unsigned(b));
	an(0) <= '0'; 
	an(1) <= '1'; 
	an(2) <= '1'; 
	an(3) <= '1'; 
	
	process(A, B, OPCODE)
       	 variable C: INTEGER range 0 to 9;
         variable OverflowFlag : BOOLEAN := FALSE;
     begin
         case OPCODE is
            when "00" =>
                
                C := TempA + TempB;
                
            when "01" =>
                
                C := TempA - TempB;
                OverflowFlag := (TempA < TempB);
            when "10" =>
               
                C := TempA * TempB;
               
            when "11" =>
               
                if TempB = 0 then
                    C := 7;
                 else
                    C := TempA / TempB;
                end if;
             --when others =>
               -- C :=0;
                --OverflowFlag := TRUE;
        end case;
       
        if OverflowFlag then
            seg<="0000110";
        else
         
            case C is
                when 0=>seg<="1000000";
                when 1=>seg<="1111001";
                when 2=>seg<="0100100";
                when 3=>seg<="0110000";
                when 4=>seg<="0011001";
                when 5=>seg<="0010010";
                when 6=>seg<="0000010";
                when 7=>seg<="0000110";
                when 8=>seg<="0000000";
                when 9=>seg<="0010000";
            
            end case;
        end if;     
       
	end process;
end behavior;