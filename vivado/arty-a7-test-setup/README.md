# NEORV32 Test Setup for the Digilent Arty A7-35 FPGA Board

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

* FPGA Board: :books: [Digilent Arty A7-35 FPGA Board](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/reference-manual)
* FPGA: Xilinx Artix-7 `XC7A35TICSG324-1L`
* Toolchain: Xilinx Vivado (tested with Vivado 2019.2)


### Interface Signals

* `rstn_i`: via board RESET button
* `clk_i`: on-board oscialltor 100MHz
* `gpio_o`: connected to the 4 green user LEDs
* `uart0_txd_o`, `uart0_rxd_i`: on-board UART_USB adapter


### FPGA Utilization

Processor hardware version: [`1.5.7.12`](https://github.com/stnolting/neorv32/blob/master/CHANGELOG.md)

```
+--------------------------------------------+------+-------+-----------+-------+
|                  Site Type                 | Used | Fixed | Available | Util% |
+--------------------------------------------+------+-------+-----------+-------+
| Slice                                      |  670 |     0 |      8150 |  8.22 |
|   SLICEL                                   |  443 |     0 |           |       |
|   SLICEM                                   |  227 |     0 |           |       |
| LUT as Logic                               | 2014 |     0 |     20800 |  9.68 |
|   using O5 output only                     |    2 |       |           |       |
|   using O6 output only                     | 1663 |       |           |       |
|   using O5 and O6                          |  349 |       |           |       |
| LUT as Memory                              |    0 |     0 |      9600 |  0.00 |
|   LUT as Distributed RAM                   |    0 |     0 |           |       |
|   LUT as Shift Register                    |    0 |     0 |           |       |
| Slice Registers                            | 1534 |     0 |     41600 |  3.69 |
|   Register driven from within the Slice    | 1042 |       |           |       |
|   Register driven from outside the Slice   |  492 |       |           |       |
|     LUT in front of the register is unused |  241 |       |           |       |
|     LUT in front of the register is used   |  251 |       |           |       |
| Unique Control Sets                        |   49 |       |      8150 |  0.60 |
+--------------------------------------------+------+-------+-----------+-------+
```

```
+-------------------+------+-------+-----------+-------+
|     Site Type     | Used | Fixed | Available | Util% |
+-------------------+------+-------+-----------+-------+
| Block RAM Tile    |    8 |     0 |        50 | 16.00 |
|   RAMB36/FIFO*    |    6 |     0 |        50 | 12.00 |
|     RAMB36E1 only |    6 |       |           |       |
|   RAMB18          |    4 |     0 |       100 |  4.00 |
|     RAMB18E1 only |    4 |       |           |       |
+-------------------+------+-------+-----------+-------+
```


