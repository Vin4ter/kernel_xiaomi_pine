#!/bin/bash

echo "64BIT kernel Pie Perf based on olive"

if [ -f gcc-linaro-4.9-2016.02-x86_64_aarch64_be-linux-gnu.tar.xz ]
then

echo "Toolchain gcc-linaro-4.9 is allready"

else

echo "Download toolchain gcc-linaro-4.9"
wget https://releases.linaro.org/components/toolchain/binaries/4.9-2016.02/aarch64_be-linux-gnu/gcc-linaro-4.9-2016.02-x86_64_aarch64_be-linux-gnu.tar.xz
fi

sudo rm -rf linaro4.9-2016-aarch64_be_linux
sudo apt-get install xz-utils
clear
echo "Unpack: toolchain gcc-linaro-4.9"
mkdir linaro4.9-2016-aarch64_be_linux
tar xvJf ${PWD}/gcc-linaro-4.9-2016.02-x86_64_aarch64_be-linux-gnu.tar.xz -C ${PWD}/
clear
echo "Clean build derectories"
sudo rm -rf out
sudo make distclean
sudo make clean
mkdir out
echo "Export parametres"
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc
echo "Compiling kernel"
export CROSS_COMPILE=${PWD}/gcc-linaro-4.9-2016.02-x86_64_aarch64_be-linux-gnu/bin/aarch64_be-linux-gnu-
make O=out REAL_CC=${PWD}/gcc-linaro-4.9-2016.02-x86_64_aarch64_be-linux-gnu/bin/aarch64_be-linux-gnu-gcc pine-perf_defconfig
#make menuconfig O=out REAL_CC=/home/alex/gcc-linaro-4.9-2016.02-x86_64_aarch64_be-linux-gnu/bin/aarch64_be-linux-gnu- pine-perf_defconfig
make -j2 O=out REAL_CC=${PWD}/gcc-linaro-4.9-2016.02-x86_64_aarch64_be-linux-gnu/bin/aarch64_be-linux-gnu-gcc 2>&1 | tee kernel.log
echo "Build end! ->>"
