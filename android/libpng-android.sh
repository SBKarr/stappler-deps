#!/bin/bash

CFLAGS="-Os"
CONFFLAGS="--enable-shared=no --enable-static=yes --with-pic=yes"
ORIGPATH=$PATH
LIBNAME=libpng
ROOT=`pwd`

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

ARCH=$1
NDKABI=$2
TARGET=arm-linux-androideabi
PNG_CONFFLAGS=

if [ "$1" == "x86" ]; then
TARGET=i686-linux-android
fi
if [ "$1" == "armeabi-v7a" ]; then
PNG_CONFFLAGS="--enable-arm-neon=api"
fi
if [ "$1" == "arm64-v8a" ]; then
TARGET=aarch64-linux-android
PNG_CONFFLAGS="--enable-arm-neon=on"
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
../../src/$LIBNAME/configure $CONFFLAGS $PNG_CONFFLAGS \
	CC=$NDKP-clang CFLAGS="$NDKF $NDKARCH" \
	LD=$NDKP-ld LDFLAGS="$NDKLDFLAGS" \
	--host=$TARGET --with-sysroot="$NDK/platforms/android-$NDKABI/$ARCHDIR"\
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	PKG_CONFIG_PATH="`pwd`/../$1/lib/pkgconfig" \
	CPPFLAGS="-I`pwd`/../$1/include --sysroot $TOOLCHAIN/sysroot" \
	LDFLAGS="-L`pwd`/../$1/lib" \
	--prefix=`pwd`
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
