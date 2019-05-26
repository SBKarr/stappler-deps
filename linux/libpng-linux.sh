#!/bin/sh

SAVED_PATH=$PATH
LIBNAME="libpng"

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

../../src/$LIBNAME/configure \
	CC="clang" CFLAGS="-Os -fPIC" \
	CPP="clang -E" CPPFLAGS="-I`pwd`/../$1/include" \
	LDFLAGS="-L`pwd`/../$1/lib" \
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	--prefix=`pwd` \
	--enable-shared=no \
	--enable-static=yes \
	--disable-unversioned-links

make
make install

cd -
rm -rf $LIBNAME

cp -f $1/include/libpng16/* $1/include
rm -rf $1/include/libpng16
mv -f $1/lib/libpng16.a $1/lib/libpng.a
mv -f $1/lib/libpng16.la $1/lib/libpng.la

}

Compile x86_64
