DATE = `date +%Y%m%d`
SRC = u-boot-main

all: clean build rel

build: setup
	make -C ${SRC} CROSS_COMPILE=arm-linux-gnueabi-

setup: ${SRC}
	make -C ${SRC} CROSS_COMPILE=arm-linux-gnueabi- mrproper
	make -C ${SRC} CROSS_COMPILE=arm-linux-gnueabi- omap3_beagle_config

clean:
	make -C ${SRC} CROSS_COMPILE=arm-linux-gnueabi- clean

save-patch:
	mv mux.patch mux.patch.old
	cd ${SRC}; git format-patch master --stdout > ../mux.patch

${SRC}/MLO: build

${SRC}/u-boot.img: build

${SRC}/u-boot.bin: build

rel: ${SRC}/MLO ${SRC}/u-boot.img ${SRC}/u-boot.bin
	rm -Rf rel/
	mkdir -p rel/
	gzip -9c ${SRC}/MLO > rel/MLO-${DATE}.gz
	gzip -9c ${SRC}/u-boot.img > rel/u-boot.img-${DATE}.gz
	gzip -9c ${SRC}/u-boot.bin > rel/u-boot.bin-${DATE}.gz

${SRC}:
	git clone git://git.denx.de/u-boot.git ${SRC}
	cd ${SRC} && git checkout --track -b omap3 origin/master \
		&& git apply --check ../mux.patch && git am --signoff ../mux.patch

.PHONY: build setup clean rel save-patch
