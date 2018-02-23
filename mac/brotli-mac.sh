#!/bin/bash

SAVED_PATH=$PATH
LIBNAME="brotli"

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

../../src/$LIBNAME/configure-cmake \
	CC="clang" CFLAGS="-Os -fPIC" \
	CXX="clang" CXXFLAGS="-Os -fPIC" \
	--prefix=`pwd` \
	--libdir=`pwd`/../$1/lib \
	--includedir=`pwd`/../$1/include \
	--disable-debug

make brotlienc-static brotlidec-static

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

Compile x86_64
