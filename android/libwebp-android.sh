#!/bin/bash

CFLAGS="-Os"
ORIGPATH=$PATH
LIBNAME=libwebp
ROOT=`pwd`

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

ARCH=$1
NDKABI=$2
TARGET=arm-linux-androideabi

if [ "$1" == "x86" ]; then
TARGET=i686-linux-android
fi
if [ "$1" == "arm64-v8a" ]; then
TARGET=aarch64-linux-android
fi
if [ "$1" == "x86_64" ]; then
TARGET=x86_64-linux-android
fi

TOOLCHAIN=$ROOT/toolchains/$1
export PATH=$TOOLCHAIN/bin:$PATH
NDKP=$TOOLCHAIN/bin/$TARGET
NDKF="$CFLAGS --sysroot $TOOLCHAIN/sysroot"
NDKARCH=$3
NDKLDFLAGS=$4
../../src/$LIBNAME/configure \
	CC=$NDKP-clang CFLAGS="$NDKF $NDKARCH" \
	LD=$NDKP-ld LDFLAGS="$NDKLDFLAGS" \
	--host=$TARGET --with-sysroot="$NDK/platforms/android-$NDKABI/$ARCHDIR"\
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	PKG_CONFIG_PATH="`pwd`/../$1/lib/pkgconfig" \
	CPPFLAGS="-I`pwd`/../$1/include --sysroot $TOOLCHAIN/sysroot" \
	LDFLAGS="-L`pwd`/../$1/lib" \
	--prefix=`pwd` \
	--enable-shared=no \
	--enable-static=yes \
	--disable-gl \
	--disable-sdl \
	--disable-png \
	--disable-jpeg \
	--disable-tiff \
	--disable-gif \
	--disable-wic

make
make install

cd -
rm -rf $LIBNAME
export PATH=$ORIGPATH

}

Compile	armeabi-v7a	14 '-march=armv7-a -mfloat-abi=softfp -mfpu=neon' '-march=armv7-a -Wl,--fix-cortex-a8'
Compile	x86 		14 '' ''
Compile	arm64-v8a 	21 '' ''
Compile	x86_64		21 '' ''
