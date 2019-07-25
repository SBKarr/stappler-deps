#!/bin/bash
# Android/ARM, armeabi (ARMv5TE soft-float), Android 2.2+ (Froyo)

if [ -z "$ANDROID_NDK_ROOT" ]; then
NDK="/home/sbkarr/android/ndk"
else
NDK="$ANDROID_NDK_ROOT"
fi

CFLAGS="-Os -fPIC"
LIBNAME=mbedtls
ROOT=`pwd`

Compile () {

NDKP=$2
NDKPAR=$3

NDKF="$CFLAGS"
NDKARCH=$4
NDKLDFLAGS=$5

rm -f ../src/mbedtls/library/libmbed*

make -C ../src/mbedtls clean
make -C ../src/mbedtls CC=$NDKP-clang AR=$NDKPAR-ar CFLAGS="$NDKF $NDKARCH" lib

mkdir -p `pwd`/$1/include
mkdir -p `pwd`/$1/lib

cp -r ../src/mbedtls/include/mbedtls `pwd`/$1/include
cp -RP ../src/mbedtls/library/libmbed* `pwd`/$1/lib

}

NDKPATH=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin

Compile armeabi-v7a $NDKPATH/armv7a-linux-androideabi19 $NDKPATH/arm-linux-androideabi '-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16' '-march=armv7-a -Wl,--fix-cortex-a8'
Compile	x86         $NDKPATH/i686-linux-android19       $NDKPATH/i686-linux-android	  '' ''
Compile	arm64-v8a   $NDKPATH/aarch64-linux-android21    $NDKPATH/aarch64-linux-android '' ''
Compile	x86_64      $NDKPATH/x86_64-linux-android21     $NDKPATH/x86_64-linux-android  '' ''
