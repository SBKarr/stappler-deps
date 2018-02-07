#!/bin/bash

CFLAGS="-Os"
ORIGPATH=$PATH
LIBNAME=brotli
ROOT=`pwd`

XCODE_BIN_PATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin"
export PATH=$XCODE_BIN_PATH:$PATH

SDK_INCLUDE_SIM="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include"
SDK_INCLUDE_OS="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include"

SYSROOT_SIM="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk"
SYSROOT_OS="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk"

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

export IPHONEOS_DEPLOYMENT_TARGET="$2"
HOST_VALUE=$1-apple-darwin
if [ "$1" == "arm64" ]; then
HOST_VALUE=arm-apple-darwin
fi

../../src/$LIBNAME/configure-cmake \
	CC=$XCODE_BIN_PATH/clang \
	CFLAGS="$CFLAGS -arch $1 -isysroot $4  -miphoneos-version-min=$2" \
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

Compile i386 6.0 $SDK_INCLUDE_SIM $SYSROOT_SIM
Compile x86_64 6.0 $SDK_INCLUDE_SIM $SYSROOT_SIM
Compile armv7 6.0 $SDK_INCLUDE_OS $SYSROOT_OS
Compile armv7s 6.0 $SDK_INCLUDE_OS $SYSROOT_OS
Compile arm64 6.0 $SDK_INCLUDE_OS $SYSROOT_OS
