#!/bin/bash
# Android/ARM, armeabi (ARMv5TE soft-float), Android 2.2+ (Froyo)

if [ -z "$ANDROID_NDK_ROOT" ]; then
NDK="/home/sbkarr/android/ndk"
else
NDK="$ANDROID_NDK_ROOT"
fi

SAVED_PATH=$PATH
LIBNAME="giflib"

Compile () {

PREFIX=`pwd`/$1

NDKP=$2
NDKPAR=$3

NDKF="-Os -std=gnu99 -fPIC -Wall"
NDKARCH=$4
NDKLDFLAGS=$5

make -C ../src/$LIBNAME CC=$NDKP-clang AR=$NDKPAR-ar clean
make -C ../src/$LIBNAME CC=$NDKP-clang AR=$NDKPAR-ar CFLAGS="$NDKF $NDKARCH" CC=clang libgif.a

mv -f ../src/$LIBNAME/libgif.a $PREFIX/lib/libgif.a
cp -f ../src/$LIBNAME/gif_lib.h $PREFIX/include/gif_lib.h

}

NDKPATH=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin

Compile armeabi-v7a $NDKPATH/armv7a-linux-androideabi19 $NDKPATH/arm-linux-androideabi '' '-Wl,--fix-cortex-a8'
Compile	x86         $NDKPATH/i686-linux-android19       $NDKPATH/i686-linux-android	  '' ''
Compile	arm64-v8a   $NDKPATH/aarch64-linux-android21    $NDKPATH/aarch64-linux-android '' ''
Compile	x86_64      $NDKPATH/x86_64-linux-android21     $NDKPATH/x86_64-linux-android  '' ''
