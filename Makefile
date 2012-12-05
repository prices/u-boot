all: clean build

build: clean setup
	make -C u-boot-main CROSS_COMPILE=arm-linux-gnueabi-
	cp u-boot-main/MLO .

setup: u-boot-main
	make -C u-boot-main CROSS_COMPILE=arm-linux-gnueabi- mrproper
	make -C u-boot-main CROSS_COMPILE=arm-linux-gnueabi- omap3_beagle_config

clean:
	make -C u-boot-main CROSS_COMPILE=arm-linux-gnueabi- clean

save:
	cd u-boot-main; git format-patch master --stdout > ../mux.patch.new


u-boot-main:
	git clone git://git.denx.de/u-boot.git u-boot-main
	cd u-boot-main && git checkout --track -b omap3 origin/master \
		&& git apply --check ../mux.patch && git am --signoff ../mux.patch

.PHONY: build setup clean save