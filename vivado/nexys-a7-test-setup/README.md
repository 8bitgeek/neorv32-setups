# NEORV32 Test Setup for the Digilent Nexys A7 and Nexys 4 DDR FPGA Boards

This setup provides a very simple script-based "demo setup" that allows to check out the NEORV32 processor.

This setup configures a `rv32imc_Zicsr` CPU with 16kB IMEM (as RAM), 8kB DMEM
and includes the GPIO module to drive 8 external signals (`gpio_o`), the MTIME
module for generating timer interrupts and UART0 to interface with the bootloader
(via `uart0_txd_o` and `uart0_rxd_i`) via a serial terminal.
The setup uses the [direct boot](https://stnolting.github.io/neorv32/#_direct_boot)
configuration, so software applications can be uploaded and run at any timer via a serial terminal.

* FPGA Boards:
  * :books: [Digilent Nexys A7 FPGA Boards](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/reference-manual)
  * :books: [Digilent Nexys 4 DDR FPGA Board](https://reference.digilentinc.com/reference/programmable-logic/nexys-4-ddr/reference-manual)
* FPGAs:
  * Xilinx Artix-7 `XC7A50TCSG324-1`
  * Xilinx Artix-7 `XC7A100TCSG324-1`
* Toolchain: Xilinx Vivado (tested with Vivado 2020.2)
