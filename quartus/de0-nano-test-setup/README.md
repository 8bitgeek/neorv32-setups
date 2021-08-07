# NEORV32 Test Setup for the Terasic DE0-Nano FPGA Board

This setup provides a very simple script-based "demo setup" that allows to check out the NEORV32 processor.

This setup configures a `rv32imc_Zicsr` CPU with 16kB IMEM (as RAM), 8kB DMEM
and includes the GPIO module to drive 8 external signals (`gpio_o`), the MTIME
module for generating timer interrupts and UART0 to interface with the bootloader
(via `uart0_txd_o` and `uart0_rxd_i`) via a serial terminal.
The setup uses the [direct boot](https://stnolting.github.io/neorv32/#_direct_boot)
configuration, so software applications can be uploaded and run at any timer via a serial terminal.

:information_source: To switch to a boot concept that directly
executed the application from pre-initialized IMEM (implemented as ROM) set the processor's `INT_BOOTLOADER_EN` to false.
See User Guide section [_Installing an Executable Directly Into Memory_](https://stnolting.github.io/neorv32/ug/#_installing_an_executable_directly_into_memory).


* FPGA Board: :books: [Terasic DE0-Nano FPGA Board](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=139&No=593)
* FPGA: Intel Cyclone-IV `EP4CE22F17C6N`
* Toolchain: Intel Quartus Prime (tested with Quartus Prime 20.1.0 - Lite Edition)


### Interface Signals

* `rstn_i`: on-board button "KEY0"
* `clk_i`: on-board oscialltor 50MHz
* `gpio_o`: connected to the 8 green user LEDs ("LED7" - "LED0")
* `uart0_txd_o`: output, connected to FPGA pin D12 - header pin GPIO_032
* `uart0_rxd_i`: input, connected to FPGA pin A12 - header pin GPIO_030


### FPGA Utilization

Processor hardware version: [`1.5.7.12`](https://github.com/stnolting/neorv32/blob/master/CHANGELOG.md)

```
Total logic elements	3,336 / 22,320 ( 15 % )
Total registers	1529
Total pins	12 / 154 ( 8 % )
Total virtual pins	0
Total memory bits	230,400 / 608,256 ( 38 % )
Embedded Multiplier 9-bit elements	0 / 132 ( 0 % )
Total PLLs	0 / 4 ( 0 % )
```


## How To Run

The `create_project.tcl` TCL script in this directory can be used to create a complete Quartus project.
If not already available, this script will create a `work` folder in this directory.

1. start Quartus (in GUI mode)
2. in the menu line click "View/Utility Windows/Tcl console" to open the Tcl console
3. use the console to naviagte to **this** folder: `cd .../neorv32/boards/de0-nano-test-setup`
4. execute `source create_project.tcl` - this will create and open the actual Quartus project in this folder
5. if a "select family" prompt appears select the "Cyclone IV E" family and click OK
6. double click on "Compile Design" in the "Tasks" window. This will synthesize, map and place & route your design and will also generate the actual FPGA bitstream
7. when the process is done open the programmer (for example via "Tools/Programmer") and click "Start" in the programmer window to upload the bitstream to your FPGA
8. use a serial terminal (like :earth_asia: [Tera Term](https://ttssh2.osdn.jp/index.html.en)) to connect to the USB-UART interface using the following configuration:
19200 Baud, 8 data bits, 1 stop bit, no parity bits, no transmission / flow control protocol (raw bytes only), newline on `\r\n` (carriage return & newline)
9. now you can communicate with the bootloader console and upload a new program. Check out the [example programs](https://github.com/stnolting/neorv32/tree/master/sw/example)
and see section "Let's Get It Started" of the :page_facing_up: [NEORV32 data sheet](https://raw.githubusercontent.com/stnolting/neorv32/master/docs/NEORV32.pdf) for further resources.
