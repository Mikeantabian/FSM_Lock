----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2023 10:00:12 AM
-- Design Name: 
-- Module Name: FSM_Lock_TB - Behavioral
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

entity FSM_Lock_TB is
--  Port ( );
end FSM_Lock_TB;

architecture Behavioral of FSM_Lock_TB is

component FSM_Lock is
    Port ( rst, new_value, clk : in STD_LOGIC;
           lock_code : in STD_LOGIC_VECTOR (3 downto 0);
           door : out STD_LOGIC);
end component FSM_Lock;

signal rst_TB, clk_TB, new_value_TB, door_TB: std_logic;
signal lock_code_TB : std_logic_vector(3 downto 0);
signal runtime: time := 10ns;
type lock_nums is array(1 to 3) of std_logic_vector(3 downto 0);
constant locks: lock_nums := ("0100", "0000", "1001");

type test_nums is array(1 to 3) of std_logic_vector(3 downto 0);
constant testValues: test_nums := ("0100", "0000", "1001");

begin

DUT: FSM_Lock port map(
    rst => rst_TB,
    clk => clk_TB,
    new_value => new_value_TB,
    lock_code => lock_code_TB,
    door => door_TB
);

-- clk process
process
begin
    clk_TB <= '1';
    wait for runtime/2;
    clk_TB <= '0';
    wait for runtime/2;
end process;

--main process
process
begin
    rst_TB <= '0';

-- Open Lock / Reset from State 3
-- num1
new_value_TB <= '0';
lock_code_TB <= locks(1);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
-- num2
new_value_TB <= '0';
lock_code_TB <= locks(2);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
-- num3
new_value_TB <= '0';
lock_code_TB <= locks(3);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
new_value_TB <= '0';
wait for runtime;
-- Reset FSM
rst_TB <= '1';
wait for runtime;
rst_TB <= '0';
wait for runtime;

-- Reset from three regular states
-- First: Reset from State 0
-- Reset FSM
lock_code_TB <= locks(1);
rst_TB <= '1';
wait for runtime;
rst_TB <= '0';
wait for runtime;

-- Second: Reset from State 1
-- num1
new_value_TB <= '0';
lock_code_TB <= locks(1);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
new_value_TB <= '0';
wait for runtime;
-- Reset FSM
rst_TB <= '1';
wait for runtime;
rst_TB <= '0';
wait for runtime;

-- Third: Reset from State 2
-- num1
new_value_TB <= '0';
lock_code_TB <= locks(1);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
-- num2
new_value_TB <= '0';
lock_code_TB <= locks(2);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
new_value_TB <= '0';
wait for runtime;
-- Reset FSM
rst_TB <= '1';
wait for runtime;
rst_TB <= '0';
wait for runtime;

-- Go To Error State, Then Reset
-- State 0 to Error State
-- Wrong number inputted
new_value_TB <= '0';
lock_code_TB <= B"1100";
wait for runtime;
new_value_TB <= '1';
wait for runtime;
new_value_TB <= '0';
wait for runtime;
-- Reset FSM
rst_TB <= '1';
wait for runtime;
rst_TB <= '0';
wait for runtime;

-- State 1 to Error State
-- num1
new_value_TB <= '0';
lock_code_TB <= locks(1);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
-- Another false input
new_value_TB <= '0';
lock_code_TB <= B"0011";
wait for runtime;
new_value_TB <= '1';
wait for runtime;
new_value_TB <= '0';
wait for runtime;
-- Reset FSM
rst_TB <= '1';
wait for runtime;
rst_TB <= '0';
wait for runtime;

-- State 2 to Error State
--num1
new_value_TB <= '0';
lock_code_TB <= locks(1);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
-- num2
new_value_TB <= '0';
lock_code_TB <= locks(2);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
-- false input 2
new_value_TB <= '0';
lock_code_TB <= B"1010";
wait for runtime;
new_value_TB <= '1';
wait for runtime;
new_value_TB <= '0';
wait for runtime;
-- Reset FSM
rst_TB <= '1';
wait for runtime;
rst_TB <= '0';
wait for runtime;

-- Open Lock / Reset from State 3
-- num1
new_value_TB <= '0';
lock_code_TB <= locks(1);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
-- num2
new_value_TB <= '0';
lock_code_TB <= locks(2);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
-- num3
new_value_TB <= '0';
lock_code_TB <= locks(3);
wait for runtime;
new_value_TB <= '1';
wait for runtime;
new_value_TB <= '0';
wait for runtime;
-- Reset FSM
rst_TB <= '1';
wait for runtime;
rst_TB <= '0';
wait;

end process;


end Behavioral;
