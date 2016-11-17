-- nes_fsm.vhd


library ieee;
use ieee.std_logic_1164.all;
use work.std_arith.all;

entity nes_fsm is
    port (
	  clk: in std_logic;
	  latch: in std_logic;
	  pulse: in std_logic;
	  data: in std_logic;

	  button: out std_logic_vector(7 downto 0)
	  );
    attribute pin_numbers of nes_fsm:entity is
	"clk:20 "	&
	"button(0):24 " &               --A0
        "button(1):25 " &
        "button(2):26 " &
        "button(3):27 " &
        "button(4):28 " &
        "button(5):29 " &
        "button(6):30 " &
        "button(7):31 " &               --A7
	"latch:58 "	&  		-- A26 (to clocks.vhd)
	"pulse:57 "	&  		-- A25 (to clocks.vhd)
	"data:56 "	&  		-- A24 (from nes)
	"";

end nes_fsm;

architecture arch of nes_fsm is

-- w is for wait, b is for button
    constant w : integer range 0 to 17 := 0;
    constant w0 : integer range 0 to 17 := 1;
    constant b0 : integer range 0 to 17 := 2;
    constant w1 : integer range 0 to 17 := 3;
    constant b1 : integer range 0 to 17 := 4;
    constant w2 : integer range 0 to 17 := 5;
    constant b2 : integer range 0 to 17 := 6;
    constant w3 : integer range 0 to 17 := 7;
    constant b3 : integer range 0 to 17 := 8;
    constant w4 : integer range 0 to 17 := 9;
    constant b4 : integer range 0 to 17 := 10;
    constant w5 : integer range 0 to 17 := 11;
    constant b5 : integer range 0 to 17 := 12;
    constant w6 : integer range 0 to 17 := 13;
    constant b6 : integer range 0 to 17 := 14;
    constant w7 : integer range 0 to 17 := 15;
    constant b7 : integer range 0 to 17 := 16;
    constant w8 : integer range 0 to 17 := 17;

    signal p_s, n_s : integer range 0 to 17 := 0;

begin  -- arch

    fsm_like_things:process(p_s, latch, pulse, data)
    begin
	case p_s is
	    when w =>
		if latch = '1' then
		    n_s <= w0;
		else
		    n_s <= w;
		end if;
	    when w0 =>
		if latch = '0' then
		    n_s <= b0;
		    button(0) <= not data;
		else
		    n_s <= w0;
		end if;
	    when b0 =>
		if pulse = '1' then
		    n_s <= w1;
		else
		    n_s <= b0;
		end if;
	    when w1 =>
		if pulse = '0' then
		    n_s <= b1;
		    button(1) <= not data;
		else
		    n_s <= w1;
		end if;
	    when b1 =>
		if pulse = '1' then
		    n_s <= w2;
		else
		    n_s <= b1;
		end if;
	    when w2 =>
		if pulse = '0' then
		    n_s <= b2;
		    button(2) <= not data;
		else
		    n_s <= w2;
		end if;
	    when b2 =>
		if pulse = '1' then
		    n_s <= w3;
		else
		    n_s <= b2;
		end if;
	    when w3 =>
		if pulse = '0' then
		    n_s <= b3;
		    button(3) <= not data;
		else
		    n_s <= w3;
		end if;
	    when b3 =>
		if pulse = '1' then
		    n_s <= w4;
		else
		    n_s <= b3;
		end if;
	    when w4 =>
		if pulse = '0' then
		    n_s <= b4;
		    button(4) <= not data;
		else
		    n_s <= w4;
		end if;
	    when b4 =>
		if pulse = '1' then
		    n_s <= w5;
		else
		    n_s <= b4;
		end if;
	    when w5 =>
		if pulse = '0' then
		    n_s <= b5;
		    button(5) <= not data;
		else
		    n_s <= w5;
		end if;
	    when b5 =>
		if pulse = '1' then
		    n_s <= w6;
		else
		    n_s <= b5;
		end if;
	    when w6 =>
		if pulse = '0' then
		    n_s <= b6;
		    button(6) <= not data;
		else
		    n_s <= w6;
		end if;
	    when b6 =>
		if pulse = '1' then
		    n_s <= w7;
		else
		    n_s <= b6;
		end if;
	    when w7 =>
		if pulse = '0' then
		    n_s <= b7;
		    button(7) <= not data;
		else
		    n_s <= w7;
		end if;
	    when b7 =>
		if pulse = '1' then
		    n_s <= w8;
		else
		    n_s <= b7;
		end if;
	    when w8 =>
		if pulse = '0' then
		    n_s <= w;
		else
		    n_s <= w8;
		end if;
	    when others =>
		if latch = '1' then
		    n_s <= w0;
		end if;
	end case;

    end process fsm_like_things;

    state_transition:process(clk)
    begin
	if rising_edge(clk) then
	    p_s <= n_s;
	end if;
    end process state_transition;

end arch;
