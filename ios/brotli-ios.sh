#!/bin/bash

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

cmake ../../src/brotli \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=`pwd` \
	-DCMAKE_INSTALL_LIBDIR=`pwd`/../$1/lib \
	-DCMAKE_C_COMPILER="$XCODE_BIN_PATH/clang" \
	-DCMAKE_C_FLAGS="-Os -arch $1 -miphoneos-version-min=$2" \
	-DCMAKE_INSTALL_INCLUDEDIR=`pwd`/../$1/include \
	-DCMAKE_OSX_SYSROOT=$4

make brotlienc-static brotlidec-static

mkdir -p `pwd`/../$1/lib/pkgconfig
mv -f *.pc `pwd`/../$1/lib/pkgconfig
sed -i -e 's/ -lbrotlidec/ -lbrotlidec -lbrotlicommon/g' `pwd`/../$1/lib/pkgconfig/libbrotlidec.pc
sed -i -e 's/ -lbrotlienc/ -lbrotlienc -lbrotlicommon/g' `pwd`/../$1/lib/pkgconfig/libbrotlienc.pc

mv -f libbrotlienc-static.a `pwd`/../$1/lib/libbrotlienc.a
mv -f libbrotlidec-static.a `pwd`/../$1/lib/libbrotlidec.a
mv -f libbrotlicommon-static.a `pwd`/../$1/lib/libbrotlicommon.a
rm -rf `pwd`/../$1/lib/brotli
mkdir -p  `pwd`/../$1/include/brotli
cp -R ../../src/$LIBNAME/c/include/brotli/* `pwd`/../$1/include/brotli

cd -
rm -rf $LIBNAME

}

Compile x86_64 11.0 $SDK_INCLUDE_SIM $SYSROOT_SIM
Compile arm64 11.0 $SDK_INCLUDE_OS $SYSROOT_OS
