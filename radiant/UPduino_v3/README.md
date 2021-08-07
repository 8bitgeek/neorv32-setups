# NEORV32 Example Setup for the tinyVision.ai Inc. "UPduino v3.0" FPGA Board

This setup provides a very simple "demo setup" using a preconfigured Lattice Radiant project
that allows to check out the NEORV32 processor.

This setup configures a size-optimized `rv32ic_Zicsr` CPU with 4kB IMEM (as RAM by default), 64kB DMEM,
**no CPU counters** (`cycle`, `instret`)
and includes the GPIO module to drive 3 external signals (`gpio_o`), the MTIME
module for generating timer interrupts and UART0 to interface with the bootloader
(via `uart0_txd_o` and `uart0_rxd_i`) via a serial terminal.
The setup uses the [direct boot](https://stnolting.github.io/neorv32/#_direct_boot)
configuration, so software applications can be uploaded and run at any timer via a serial terminal.

:warning: By default, this setup uses the processor-internal bootloader to upload new executable via
UART. Hence, the internal IMEM will be implemented as RAM (using EBR). To switch to a boot concept that directly
executed the application from pre-initialized IMEM (implemented as ROM) set the processor's `INT_BOOTLOADER_EN` to false.
See User Guide section [_Installing an Executable Directly Into Memory_](https://stnolting.github.io/neorv32/ug/#_installing_an_executable_directly_into_memory).

:information_source: This setup uses optimized platform-specific memory modules for the internal data memory (DMEM). It uses two
UltraPlus SPRAM primitives (total memory size per memory = 2 x 32kB = 64kB).
VHDL source file for platform-specific DMEM: `neorv32_dmem.ice40up_spram.vhd`.
This platform-specific memory are used *instead* of the default platform-agnostic module from the core's `rtl/core` folder.
Note that the IMEM is usigng the default paltform-agnostic architecture (using EBR), which can be _initialized_ (with the software application) during
synthesis. If you are using the bootloader boot concept you can replace this by the platform-specific IMEM: `neorv32_imem.ice40up_spram.vhd`.

* FPGA Board: :books: [tinyVision.ai Inc. UPduino v3 FPGA Board (GitHub)](https://github.com/tinyvision-ai-inc/UPduino-v3.0/), :credit_card: buy on [Tindie](https://www.tindie.com/products/tinyvision_ai/upduino-v30-low-cost-lattice-ice40-fpga-board/)
* FPGA: Lattice iCE40 UltraPlus 5k `iCE40UP5K-SG48I`
* Toolchain: Lattice Radiant (tested with Radiant version 2.1.0), using *Lattice Synthesis Engine (LSE)*


### Interface Signals

:information_source: See [`neorv32_upduino_v3.pdc`](https://github.com/stnolting/neorv32/blob/main/boards/UPduino_v3/neorv32_upduino_v3.pdc)
for the FPGA pin mapping.

| Top Entity Signal    | FPGA Pin   | Package Pin  | Board Header Pin |
|:---------------------|:----------:|:------------:|:-----------------|
| `rgb_o(0)` (red)     | RGB2       | 41           | J2-5             |
| `rgb_o(1)` (green)   | RGB0       | 39           | J2-6             |
| `rgb_o(2)` (blue)    | RGB1       | 40           | J2-7             |
| `uart_txd_o` (UART0) | IOT_50B    | 38           | J2-15            |
| `uart_rxd_i` (UART0) | IOT_41A    | 28           | J2-16            |

:information_source: The setup uses the on-chip HF oscillator as clock source (12MHz).

### FPGA Utilization

```
Number of slice registers: 1128 out of  5280 (21%)
Number of I/O registers:      1 out of   117 (1%)
Number of LUT4s:           3268 out of  5280 (62%)
Number of IO sites used:   5 out of 39 (13%)
Number of DSPs:             0 out of 8 (0%)
Number of I2Cs:             0 out of 2 (0%)
Number of High Speed OSCs:  1 out of 1 (100%)
Number of Low Speed OSCs:   0 out of 1 (0%)
Number of RGB PWM:          0 out of 1 (0%)
Number of RGB Drivers:      1 out of 1 (100%)
Number of SCL FILTERs:      0 out of 2 (0%)
Number of SRAMs:            2 out of 4 (50%)
Number of WARMBOOTs:        0 out of 1 (0%)
Number of SPIs:             0 out of 2 (0%)
Number of EBRs:             20 out of 30 (66%)
Number of PLLs:             0 out of 1 (0%)
```

## How To Run

#### FPGA Setup

1. start Lattice Radiant (in GUI mode)
2. click on "open project" and select `neorv32_upduino_v3.rdf` from this folder
3. click the :arrow_forward: button to synthesize, map, place and route the design and to generate a programming file
4. when done open the programmer (for example via "Tools" -> "Programmer"); you will need a programmer configuration, which will be created in the next steps; alternatively,
you can use the pre-build configuration `source/impl_1.xcf`
5. in the programmer double click on the field under "Operation" (_fast configuration_ should be the default) and select "External SPI Memory" as "Target Memory"
6. select "SPI Serial Flash" under "SPI Flash Options / Family"
7. select "WinBond" under "SPI Flash Options / Vendor"
8. select "W25Q32" under "SPI Flash Options / Device"
9. close the dialog by clicking "ok"
10. click on "Program Device"
