## This file is a general .xdc for the Arty A7-35 Rev. D

## Clock signal
set_property -dict { PACKAGE_PIN E3   IOSTANDARD LVCMOS33 } [get_ports { clk_i }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk_i }];
## Reset.
set_property -dict { PACKAGE_PIN C2   IOSTANDARD LVCMOS33 } [get_ports { rstn_i }]; #IO_L16P_T2_35 Sch=ck_rst

## LEDs
set_property -dict { PACKAGE_PIN H5   IOSTANDARD LVCMOS33 } [get_ports { gpio_o[0] }]; #IO_L24N_T3_35 Sch=led[4]
set_property -dict { PACKAGE_PIN J5   IOSTANDARD LVCMOS33 } [get_ports { gpio_o[1] }]; #IO_25_35 Sch=led[5]
set_property -dict { PACKAGE_PIN T9   IOSTANDARD LVCMOS33 } [get_ports { gpio_o[2] }]; #IO_L24P_T3_A01_D17_14 Sch=led[6]
set_property -dict { PACKAGE_PIN T10  IOSTANDARD LVCMOS33 } [get_ports { gpio_o[3] }]; #IO_L24N_T3_A00_D16_14 Sch=led[7]

## USB-UART Interface
set_property -dict { PACKAGE_PIN D10  IOSTANDARD LVCMOS33 } [get_ports { uart0_txd_o }]; #IO_L19N_T3_VREF_16 Sch=uart_rxd_out
set_property -dict { PACKAGE_PIN A9   IOSTANDARD LVCMOS33 } [get_ports { uart0_rxd_i }]; #IO_L14N_T2_SRCC_16 Sch=uart_txd_in

