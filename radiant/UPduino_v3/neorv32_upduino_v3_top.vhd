-- #################################################################################################
-- # << NEORV32 - Example setup for the tinyVision.ai Inc. "UPduino v3" (c) Board >>               #
-- # ********************************************************************************************* #
-- # BSD 3-Clause License                                                                          #
-- #                                                                                               #
-- # Copyright (c) 2021, Stephan Nolting. All rights reserved.                                     #
-- #                                                                                               #
-- # Redistribution and use in source and binary forms, with or without modification, are          #
-- # permitted provided that the following conditions are met:                                     #
-- #                                                                                               #
-- # 1. Redistributions of source code must retain the above copyright notice, this list of        #
-- #    conditions and the following disclaimer.                                                   #
-- #                                                                                               #
-- # 2. Redistributions in binary form must reproduce the above copyright notice, this list of     #
-- #    conditions and the following disclaimer in the documentation and/or other materials        #
-- #    provided with the distribution.                                                            #
-- #                                                                                               #
-- # 3. Neither the name of the copyright holder nor the names of its contributors may be used to  #
-- #    endorse or promote products derived from this software without specific prior written      #
-- #    permission.                                                                                #
-- #                                                                                               #
-- # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS   #
-- # OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF               #
-- # MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE    #
-- # COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,     #
-- # EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE #
-- # GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED    #
-- # AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     #
-- # NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED  #
-- # OF THE POSSIBILITY OF SUCH DAMAGE.                                                            #
-- # ********************************************************************************************* #
-- # The NEORV32 Processor - https://github.com/stnolting/neorv32              (c) Stephan Nolting #
-- #################################################################################################

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library neorv32;
use neorv32.neorv32_package.all;

library work;
use work.all;

library iCE40UP;
use iCE40UP.components.all; -- for device primitives

entity neorv32_upduino_v3_top is
  port (
    -- UART --
    uart_txd_o : out std_ulogic;
    uart_rxd_i : in  std_ulogic;
    -- on-board RGB power LED --
    rgb_o      : out std_ulogic_vector(2 downto 0)
  );
end neorv32_upduino_v3_top;

architecture neorv32_upduino_v3_top_rtl of neorv32_upduino_v3_top is

  -- On-chip oscillator --
  signal hf_osc_clk : std_logic;
  signal cpu_clk    : std_ulogic;

  -- CPU --
  signal reset_cnt : std_ulogic_vector(9 downto 0) := (others => '0');
  signal cpu_rstn  : std_ulogic;

  -- internal IO connection --
  signal gpio_con   : std_ulogic_vector(63 downto 0);
  signal con_pwm    : std_ulogic_vector(2 downto 0);
  signal rgb_drive  : std_logic_vector(2 downto 0);
  signal rgb_driven : std_ulogic_vector(2 downto 0);

begin

  -- On-Chip HF Oscillator ------------------------------------------------------------------
  -- -------------------------------------------------------------------------------------------
  HSOSC_inst : HSOSC
  generic map (
    CLKHF_DIV => "0b10" -- 12 MHz
  )
  port map (
    CLKHFPU => '1',
    CLKHFEN => '1',
    CLKHF   => hf_osc_clk
  );

  cpu_clk <= std_ulogic(hf_osc_clk);


  -- Reset Generator ------------------------------------------------------------------------
  -- -------------------------------------------------------------------------------------------
  reset_gen: process(cpu_clk)
  begin
    if rising_edge(cpu_clk) then
      if (reset_cnt(reset_cnt'left) = '0') then
        reset_cnt <= std_ulogic_vector(unsigned(reset_cnt) + 1);
      end if;
    end if;
  end process reset_gen;

  cpu_rstn <= std_ulogic(reset_cnt(reset_cnt'left));


  -- The Core Of The Problem ----------------------------------------------------------------
  -- -------------------------------------------------------------------------------------------
  neorv32_top_inst: neorv32_top
  generic map (
    -- General --
    CLOCK_FREQUENCY              => 12000000, -- clock frequency of clk_i in Hz
    INT_BOOTLOADER_EN            => true,     -- boot configuration: true = boot explicit bootloader; false = boot from int/ext (I)MEM
    -- RISC-V CPU Extensions --
    CPU_EXTENSION_RISCV_C        => true,     -- implement compressed extension?
    CPU_EXTENSION_RISCV_Zicsr    => true,     -- implement CSR system?
    -- Extension Options --
    CPU_CNT_WIDTH                => 0,        -- total width of CPU cycle and instret counters (0..64)
    CPU_IPB_ENTRIES              => 1,        -- entries is instruction prefetch buffer, has to be a power of 2
    -- Internal Instruction memory --
    MEM_INT_IMEM_EN              => true,     -- implement processor-internal instruction memory
    MEM_INT_IMEM_SIZE            => 4*1024,   -- size of processor-internal instruction memory in bytes
    -- Internal Data memory --
    MEM_INT_DMEM_EN              => true,     -- implement processor-internal data memory
    MEM_INT_DMEM_SIZE            => 64*1024,  -- size of processor-internal data memory in bytes
    -- Processor peripherals --
    IO_GPIO_EN                   => true,     -- implement general purpose input/output port unit (GPIO)?
    IO_MTIME_EN                  => true,     -- implement machine system timer (MTIME)?
    IO_UART0_EN                  => true      -- implement primary universal asynchronous receiver/transmitter (UART0)?
  )
  port map (
    -- Global control --
    clk_i       => cpu_clk,       -- global clock, rising edge
    rstn_i      => cpu_rstn,      -- global reset, low-active, async
    -- GPIO (available if IO_GPIO_EN = true) --
    gpio_o      => gpio_con,       -- parallel output
    -- primary UART0 (available if IO_UART0_EN = true) --
    uart0_txd_o => uart_txd_o,    -- UART0 send data
    uart0_rxd_i => uart_rxd_i     -- UART0 receive data
  );

  con_pwm <= gpio_con(2 downto 0);
  rgb_drive <= std_logic_vector(con_pwm);

  RGB_inst: RGB
  generic map (
    CURRENT_MODE => "1",
    RGB0_CURRENT => "0b000001",
    RGB1_CURRENT => "0b000001",
    RGB2_CURRENT => "0b000001"
  )
  port map (
    CURREN   => '1',  -- I
    RGBLEDEN => '1',  -- I
    RGB0PWM  => rgb_drive(1),  -- I - green
    RGB1PWM  => rgb_drive(2),  -- I - blue
    RGB2PWM  => rgb_drive(0),  -- I - red
    RGB2     => rgb_driven(2), -- O - red
    RGB1     => rgb_driven(1), -- O - blue
    RGB0     => rgb_driven(0)  -- O - green
  );

  rgb_o <= std_ulogic_vector(rgb_driven);


end neorv32_upduino_v3_top_rtl;
