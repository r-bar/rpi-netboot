PI_EEPROM_VERSION := pieeprom-2021-01-05

.DEFAULT: install
.PHONY: installl
install: build/${PI_EEPROM_VERSION}-netboot.bin
	sudo rpi-eeprom-update -d -f $<


build/${PI_EEPROM_VERSION}.bin:
	curl -sL https://github.com/raspberrypi/rpi-eeprom/raw/master/firmware/beta/${PI_EEPROM_VERSION}.bin > $@


build/bootconf.txt: build/${PI_EEPROM_VERSION}.bin
	sudo rpi-eeprom-config $< > $@
	sed -i 's/BOOT_ORDER=.*/BOOT_ORDER=0xf241/g' $@


build/${PI_EEPROM_VERSION}-netboot.bin: build/bootconf.txt build/${PI_EEPROM_VERSION}.bin
	sudo rpi-eeprom-config --out $@ --config $^


.PHONY: clean
clean:
	rm -rf build/*
