#!/bin/bash

CFLAGS="-Os"
ORIGPATH=$PATH
LIBNAME=brotli
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

../../src/$LIBNAME/configure-cmake \
	CC=$NDKP-clang CFLAGS="$NDKF $NDKARCH" \
	--prefix=`pwd` \
	--libdir=`pwd`/../$1/lib \
	--includedir=`pwd`/../$1/include \
	--disable-debug

make brotlienc-static brotlidec-static

mkdir -p `pwd`/../$1/lib/pkgconfig
mv -f *.pc `pwd`/../$1/lib/pkgconfig
sed -i -e 's/ -lbrotlidec/ -lbrotlidec -lbrotlicommon/g' `pwd`/../$1/lib/pkgconfig/libbrotlidec.pc
sed -i -e 's/ -lbrotlienc/ -lbrotlienc -lbrotlicommon/g' `pwd`/../$1/lib/pkgconfig/libbrotlienc.pc

mv -f libbrotlienc-static.a `pwd`/../$1/lib/libbrotlienc.a
mv -f libbrotlidec-static.a `pwd`/../$1/lib/libbrotlidec.a
mv -f libbrotlicommon-static.a `pwd`/../$1/lib/libbrotlicommon.a
rm -rf `pwd`/../$1/lib/brotli
cp -R ../../src/$LIBNAME/c/include/brotli `pwd`/../$1/include/

cd -
rm -rf $LIBNAME
export PATH=$ORIGPATH

}

Compile	armeabi-v7a	14 '-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16' '-march=armv7-a -Wl,--fix-cortex-a8'
Compile	x86 		14 '' ''
Compile	arm64-v8a 	21 '' ''
Compile	x86_64		21 '' ''
