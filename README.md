# VHDL Testing Platform

## Requirements:
* a Zybo Z7020
* a micro SD card(min 16GB)
* a Linux Computer
* Petalinux 2017.4
* Vivado 2017.4
* Vivado Partial Reconfiguration Licence

## Get the project
After installing Vivado 2017.4 and Petalinux 2017.4, clone the project.

```
source /path/to/vivado/settings64.sh
source /path/to/petalinux/settings64.sh

git clone --recursive https://github.com/braun-vogt/VHDL_Testing_Platform.git
```

## Build Petalinux Image

```
cd VHDL_Testing_Platform
cd petalinux
petalinux-config --get-hw-description=../hw_handoff
petalinux-build
petalinux-package --boot --fsbl image/linux/zynq.elf --fpga image/linux/top.bit --u-boot
```
Copy BOOT.bin and image.db to the formatted SD Card and flash the filesystem.
