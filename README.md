## :construction: This Repository Is Still Under Construction :construction:

[![license](https://img.shields.io/github/license/stnolting/neorv32?longCache=true&style=flat-square)](https://github.com/stnolting/neorv32-setups/blob/main/LICENSE)
[![Implementation](https://img.shields.io/github/workflow/status/stnolting/neorv32-setups/Implementation/main?longCache=true&style=flat-square&label=Implementation&logo=Github%20Actions&logoColor=fff)](https://github.com/stnolting/neorv32-setups/actions?query=workflow%3AImplementation)
[![Windows](https://img.shields.io/github/workflow/status/stnolting/neorv32-setups/Windows/main?longCache=true&style=flat-square&label=Windows&logo=Github%20Actions&logoColor=fff)](https://github.com/stnolting/neorv32-setups/actions?query=workflow%3AWindows)

# Example Setups for the [NEORV32 RISC-V Processor](https://github.com/stnolting/neorv32)

This repository provides exemplary NEORV32 SoC setups for different FPGAs, boards and toolchains.
You can directly use one of the provided setups or use them as starting point to build your own setup.
Project maintainers may make pull requests against this repository to add or link their setups.

:warning: This repository uses [`neorv32`](https://github.com/stnolting/neorv32) as _git submodule_.
Make sure to use `git clone --recursive` when cloning.


## Setups using Commercial Toolchains

| Setup | Toolchain | Board | FPGA  | Author(s) |
|:------|:----------|:------|:------|:----------|
| [`de0-nano-test-setup`](https://github.com/stnolting/neorv32-setups/tree/main/quartus/de0-nano-test-setup) | Intel Quartus Prime | [Terasic DE0-Nano](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=139&No=593) | Intel Cyclone IV `EP4CE22F17C6N` | [stnolting](https://github.com/stnolting) |
| [`UPduino_v3`](https://github.com/stnolting/neorv32-setups/tree/main/radiant/UPduino_v3) | Lattice Radiant | [tinyVision.ai Inc. UPduino v3.0](https://www.tindie.com/products/tinyvision_ai/upduino-v30-low-cost-lattice-ice40-fpga-board/) | Lattice iCE40 UltraPlus `iCE40UP5K-SG48I`| [stnolting](https://github.com/stnolting) |
| [`arty-a7-35-test-setup`](https://github.com/stnolting/neorv32-setups/tree/main/vivado/arty-a7-test-setup) | Xilinx Vivado | [Digilent Arty A7-35](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/start) | Xilinx Artix-7 `XC7A35TICSG324-1L` | [stnolting](https://github.com/stnolting) |
| [`nexys-a7-test-setup`](https://github.com/stnolting/neorv32-setups/tree/main/vivado/nexys-a7-test-setup) | Xilinx Vivado | [Digilent Nexys A7](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/start) | Xilinx Artix-7 `XC7A50TCSG324-1` | [AWenzel83](https://github.com/AWenzel83) |
| [`nexys-a7-test-setup`](https://github.com/stnolting/neorv32-setups/tree/main/vivado/nexys-a7-test-setup) | Xilinx Vivado | [Digilent Nexys 4 DDR](https://reference.digilentinc.com/reference/programmable-logic/nexys-4-ddr/start) | Xilinx Artix-7 `XC7A100TCSG324-1` | [AWenzel83](https://github.com/AWenzel83) |


## Setups using Open-Source Toolchains

| Setup | Toolchain | Board | FPGA  | Author(s) |
|:------|:----------|:------|:------|:----------|
| [`UPduino v3`](https://github.com/stnolting/neorv32-setups/tree/main/osflow/README.md) | GHDL, Yosys, nextPNR | [UPduino v3.0](https://www.tindie.com/products/tinyvision_ai/upduino-v30-low-cost-lattice-ice40-fpga-board/) | Lattice iCE40 UltraPlus `iCE40UP5K-SG48I` | [tmeissner](https://github.com/tmeissner) |
| [`FOMU`](https://github.com/stnolting/neorv32-setups/tree/main/osflow/README.md) | GHDL, Yosys, nextPNR | [FOMU](https://tomu.im/fomu.html) | Lattice iCE40 UltraPlus `iCE40UP5K-SG48I` | [umarcor](https://github.com/umarcor) |
| [`iCESugar`](https://github.com/stnolting/neorv32-setups/tree/main/osflow/README.md) | GHDL, Yosys, nextPNR | [iCESugar](https://github.com/wuxx/icesugar/blob/master/README_en.md) | Lattice iCE40 UltraPlus `iCE40UP5K-SG48I` | [umarcor](https://github.com/umarcor) |
| [`Orange Crab`](https://github.com/stnolting/neorv32-setups/tree/main/osflow/README.md) | GHDL, Yosys, nextPNR | [Orange Crab](https://github.com/gregdavill/OrangeCrab) | Lattice ECP5-25F | [umarcor](https://github.com/umarcor), [jeremyherbert](https://github.com/jeremyherbert) |
| [`UPduino v3`](https://github.com/stnolting/neorv32-setups/tree/main/osflow/README.md) | GHDL, Yosys, nextPNR | [UPduino v3.0](https://www.tindie.com/products/tinyvision_ai/upduino-v30-low-cost-lattice-ice40-fpga-board/) | Lattice iCE40 UltraPlus `iCE40UP5K-SG48I` | [umarcor](https://github.com/umarcor) |

----------

### Setup-Specifc NEORV32 Software Framework Modifications

In order to use the features provided by the setups, minor *optional* changes *can* be made to the default NEORV32 setup.

* To change the default data memory size (DMEM, linker script) take a look at User Guide section :books:
[_General Software Framework Setup_](https://stnolting.github.io/neorv32/ug/#_general_software_framework_setup)
* To modify the SPI flash base address for storing/booting software applications using the bootloader see User Guide section :books:
[_Customizing the Internal Bootloader_](https://stnolting.github.io/neorv32/ug/#_customizing_the_internal_bootloader)


### Adding Your Project Setup

Please respect the following guidelines if you'd like to add (or link) your setup to the list.

* check out the project's [code of conduct](https://github.com/stnolting/neorv32-setup/tree/main/CODE_OF_CONDUCT.md)
* add a link if the board you are using provides online documentation (and/or can be purchased somewhere)
* add the :earth_africa: emoji (`:earth_africa:`) if it is a _link_ to your _local_ project
* please add a `README` to give some brief information about the setup and a `.gitignore` to keep things clean; take a look at [`arty-a7-35-test-setup`](https://github.com/stnolting/neorv32/setups/boards/arty-a7-35-test-setup) to get some ideas what a project setup might look like
