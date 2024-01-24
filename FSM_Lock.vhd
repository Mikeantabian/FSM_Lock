----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2023 09:29:25 AM
-- Design Name: 
-- Module Name: FSM_Lock - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM_Lock is
    Port ( rst, new_value, clk : in STD_LOGIC;
           lock_code : in STD_LOGIC_VECTOR (3 downto 0);
           door : out STD_LOGIC);
end FSM_Lock;

architecture Behavioral of FSM_Lock is

type StateType is (S0, S1, S2, S3, Err);
signal State: StateType;
type lock_nums is array(1 to 3) of std_logic_vector(3 downto 0);
constant nums: lock_nums := ("0100", "0000", "1001"); 

begin

process(clk, rst, new_value)
begin
    if (rst = '1') then
        State <= S0;
    elsif rising_edge(clk) then
        case State is
            when S0 =>
                if (new_value = '1') then
                    if (nums(1) = lock_code) then
                        State <= S1;
                    else 
                        State <= Err;
                    end if;
                else
                    State <= S0;
                end if;
            when S1 =>
                if (new_value = '1') then
                    if (nums(2) = lock_code) then
                        State <= S2;
                    else 
                        State <= Err;
                    end if;
                else
                    State <= S1;
                end if;
            when S2 =>
                if (new_value = '1') then
                    if (nums(3) = lock_code) then
                        State <= S3;
                    else 
                        State <= Err;
                    end if;
                else
                    State <= S2;
                end if;
            when S3 =>
                if (rst = '1') then
                    State <= S0;
                else
                    State <= S3;
                end if;
            when others =>
                State <= S0;
        end case;
    end if;
    case State is
        when S3 => door <= '1';
        when others => door <= '0';
    end case; 
end process;

end Behavioral;
