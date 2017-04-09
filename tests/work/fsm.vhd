-- fsm.vhd: Finite State Machine
-- Author(s): Dominik Harmim <xharmi00@stud.fit.vutbr.cz>

library ieee;
use ieee.std_logic_1164.all;

-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (
         C1, C2, C3, C4, C5,
         C1_1, C1_2, C1_3, C1_4, C1_5,
         C2_1, C2_2, C2_3, C2_4, C2_5, C2_6,
         BAD, ACCESS_DENIED, ACCESS_ALLOWED, FINISH
      );
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= C1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is

   when C1 =>
      if (KEY(7) = '1') then
         next_state <= C2;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C1;
      end if;

   when C2 =>
      if (KEY(6) = '1') then
         next_state <= C3;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C2;
      end if;

   when C3 =>
      if (KEY(7) = '1') then
         next_state <= C4;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C3;
      end if;

   when C4 =>
      if (KEY(1) = '1') then
         next_state <= C5;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C4;
      end if;

   when C5 =>
      if (KEY(0) = '1') then
         next_state <= C1_1;
      elsif (KEY(2) = '1') then
         next_state <= C2_1;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C5;
      end if;

   when C1_1 =>
      if (KEY(8) = '1') then
         next_state <= C1_2;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C1_1;
      end if;

   when C1_2 =>
      if (KEY(0) = '1') then
         next_state <= C1_3;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C1_2;
      end if;

   when C1_3 =>
      if (KEY(8) = '1') then
         next_state <= C1_4;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C1_3;
      end if;

   when C1_4 =>
      if (KEY(8) = '1') then
         next_state <= C1_5;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C1_4;
      end if;

   when C1_5 =>
      if (KEY(15) = '1') then
         next_state <= ACCESS_ALLOWED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C1_5;
      end if;

   when C2_1 =>
      if (KEY(1) = '1') then
         next_state <= C2_2;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C2_1;
      end if;

   when C2_2 =>
      if (KEY(6) = '1') then
         next_state <= C2_3;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C2_2;
      end if;

   when C2_3 =>
      if (KEY(1) = '1') then
         next_state <= C2_4;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C2_3;
      end if;

   when C2_4 =>
      if (KEY(7) = '1') then
         next_state <= C2_5;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C2_4;
      end if;

   when C2_5 =>
      if (KEY(7) = '1') then
         next_state <= C2_6;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C2_5;
      end if;

   when C2_6 =>
      if (KEY(15) = '1') then
         next_state <= ACCESS_ALLOWED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= C2_6;
      end if;

   when BAD =>
      next_state <= BAD;
      if (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      end if;

   when ACCESS_DENIED =>
      next_state <= ACCESS_DENIED;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;

   when ACCESS_ALLOWED =>
      next_state <= ACCESS_ALLOWED;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;

   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= C1;
      end if;

   when others =>
      null;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is

   when ACCESS_DENIED =>
      FSM_CNT_CE <= '1';
      FSM_MX_LCD <= '1';

      if (CNT_OF = '0') then
         FSM_LCD_WR <= '1';
      end if;

   when ACCESS_ALLOWED =>
      FSM_CNT_CE <= '1';
      FSM_MX_MEM <= '1';
      FSM_MX_LCD <= '1';

      if (CNT_OF = '0') then
         FSM_LCD_WR <= '1';
      end if;

   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR <= '1';
      end if;

   when others =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR <= '1';
      elsif (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR <= '1';
      end if;
   end case;

end process output_logic;

end architecture behavioral;
