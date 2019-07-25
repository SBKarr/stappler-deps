#!/bin/bash

if [ -z "$ANDROID_NDK_ROOT" ]; then
NDK="/home/sbkarr/android/ndk"
else
NDK="$ANDROID_NDK_ROOT"
fi

CFLAGS="-Os -D_FILE_OFFSET_BITS=32 -fPIC"
LIBNAME=sqlite
ROOT=`pwd`

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

NDKP=$2
NDKPAR=$3

NDKF="$CFLAGS"
NDKARCH=$4
NDKLDFLAGS=$5

$NDKP-clang $CFLAGS $NDKARCH -c -o sqlite3.o ../../src/sqlite/sqlite3.c
$NDKPAR-ar rcs libsqlite3.a sqlite3.o

rm -f ../$1/lib/libsqlite3.a
rm -f ../$1/include/sqlite3.h

mv -f libsqlite3.a ../$1/lib/
cp -f ../../src/sqlite/*.h ../$1/include/

cd -
rm -rf $LIBNAME

}

NDKPATH=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin

Compile armeabi-v7a $NDKPATH/armv7a-linux-androideabi19 $NDKPATH/arm-linux-androideabi '-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16' '-march=armv7-a -Wl,--fix-cortex-a8'
Compile	x86         $NDKPATH/i686-linux-android19       $NDKPATH/i686-linux-android	  '' ''
Compile	arm64-v8a   $NDKPATH/aarch64-linux-android21    $NDKPATH/aarch64-linux-android '' ''
Compile	x86_64      $NDKPATH/x86_64-linux-android21     $NDKPATH/x86_64-linux-android  '' ''
