# VHDL Testing Platform

## Requirements:
* a Zybo Z7020
* a micro SD card(min 16GB)
* a Linux Computer
* IP Cam
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

## Network Setup
1) Connect the Zybo and the IP Cam to a Network with DHCP. 
2) Navigate to the IP of the Zybo. for example: http://192.168.1.2/cgi-bin/gpio
3) Select a user with http://192.168.1.2/cgi-bin/gpio?user=philipp
