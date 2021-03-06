#!/bin/sh

CFLAGS="-Os"
ORIGPATH=$PATH
LIBNAME=freetype
ROOT=`pwd`

XCODE_BIN_PATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin"
#export PATH=$XCODE_BIN_PATH:$PATH

SDK_INCLUDE_SIM="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include"
SDK_INCLUDE_OS="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include"

SYSROOT_SIM="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk"
SYSROOT_OS="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"

Compile () {
mkdir -p $LIBNAME
cd $LIBNAME

#export IPHONEOS_DEPLOYMENT_TARGET="$2"
HOST_VALUE=$1-apple-darwin
if [ "$1" == "arm64" ]; then
HOST_VALUE=arm-apple-darwin
fi

#export CCexe=clang

INCLUDE_PATH=`pwd`/../$1/include

../../src/$LIBNAME/configure \
	CC_BUILD=/usr/bin/clang \
	CC=$XCODE_BIN_PATH/clang \
	CPP="$XCODE_BIN_PATH/clang -E" \
	CFLAGS="$CFLAGS -arch $1 -isysroot $4  -miphoneos-version-min=$2" \
	LDFLAGS="-arch $1 -isysroot $4 -miphoneos-version-min=$2 -L`pwd`/../$1/lib" \
	CPPFLAGS="-arch $1 -I`pwd`/../$1/include -isysroot $4" \
	PKG_CONFIG_PATH="`pwd`/../$1/lib/pkgconfig" \
	--host=$HOST_VALUE \
	--with-sysroot="$4" \
	--prefix=`pwd` \
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	--with-bzip2=no --with-zlib=yes --with-png=yes --enable-static=yes --enable-shared=no

make CCexe=gcc
make CCexe=gcc install

cd -
rm -rf $LIBNAME

cp -rf $1/include/freetype2/* $1/include
rm -rf $1/include/freetype2

}

Compile x86_64 11.0 $SDK_INCLUDE_SIM $SYSROOT_SIM
Compile arm64 11.0 $SDK_INCLUDE_OS $SYSROOT_OS
