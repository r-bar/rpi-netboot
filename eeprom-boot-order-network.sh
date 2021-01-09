#!/bin/bash

PI_EEPROM_VERSION=pieeprom-2021-01-05
wget https://github.com/raspberrypi/rpi-eeprom/raw/master/firmware/beta/${PI_EEPROM_VERSION}.bin
sudo rpi-eeprom-config ${PI_EEPROM_VERSION}.bin > bootconf.txt
sed -i 's/BOOT_ORDER=.*/BOOT_ORDER=0xf241/g' bootconf.txt
sudo rpi-eeprom-config --out ${PI_EEPROM_VERSION}-netboot.bin --config bootconf.txt ${PI_EEPROM_VERSION}.bin
sudo rpi-eeprom-update -d -f ./${PI_EEPROM_VERSION}-netboot.bin
