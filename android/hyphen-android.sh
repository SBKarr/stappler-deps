#!/bin/bash
# Android/ARM, armeabi (ARMv5TE soft-float), Android 2.2+ (Froyo)

if [ -z "$ANDROID_NDK_ROOT" ]; then
NDK="/home/sbkarr/android/ndk"
else
NDK="$ANDROID_NDK_ROOT"
fi

CFLAGS="-Os"
CONFFLAGS="--enable-shared=no --enable-static=yes --with-pic=yes"
LIBNAME=hyphen
ROOT=`pwd`

cd ../external/$LIBNAME
autoreconf -fvi
cd -

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

NDKP=$2
TARGET=$3

NDKF="$CFLAGS"
NDKARCH=$4
NDKLDFLAGS=$5

../../external/$LIBNAME/configure $CONFFLAGS \
	CC=$NDKP-clang CFLAGS="$NDKF $NDKARCH" \
	LD=$NDKP-ld LDFLAGS="$NDKLDFLAGS" \
	--host=$TARGET \
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	CPPFLAGS="-I`pwd`/../$1/include" \
	LDFLAGS="-L`pwd`/../$1/lib" \
	--prefix=`pwd`
make
make install

cd -
rm -rf $LIBNAME

}

NDKPATH=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin

Compile armeabi-v7a $NDKPATH/armv7a-linux-androideabi19  arm-linux-androideabi '-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16' '-march=armv7-a -Wl,--fix-cortex-a8'
Compile	x86         $NDKPATH/i686-linux-android19    i686-linux-android	  '' ''
Compile	arm64-v8a   $NDKPATH/aarch64-linux-android21 aarch64-linux-android '' ''
Compile	x86_64      $NDKPATH/x86_64-linux-android21  x86_64-linux-android  '' ''
