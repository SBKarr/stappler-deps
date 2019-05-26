#!/bin/bash

if [ -z "$ANDROID_NDK_ROOT" ]; then
NDK="/home/sbkarr/android/ndk"
else
NDK="$ANDROID_NDK_ROOT"
fi

CFLAGS="-Os"
LIBNAME=brotli
ROOT=`pwd`

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

NDKP=$2
TARGET=$3

NDKF="$CFLAGS"
NDKARCH=$4
NDKLDFLAGS=$5

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

}

NDKPATH=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin

Compile armeabi-v7a $NDKPATH/armv7a-linux-androideabi19  arm-linux-androideabi '-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16' '-march=armv7-a -Wl,--fix-cortex-a8'
Compile	x86         $NDKPATH/i686-linux-android19    i686-linux-android	  '' ''
Compile	arm64-v8a   $NDKPATH/aarch64-linux-android21 aarch64-linux-android '' ''
Compile	x86_64      $NDKPATH/x86_64-linux-android21  x86_64-linux-android  '' ''
