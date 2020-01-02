#!/bin/sh

SAVED_PATH=$PATH
LIBNAME="libidn2"

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

../../src/$LIBNAME/configure \
	CFLAGS="-Os -fPIC" \
	CPPFLAGS="-I`pwd`/../$1/include" \
	LDFLAGS="-L`pwd`/../$1/lib" \
	PKG_CONFIG_PATH="`pwd`/../$1/lib/pkgconfig" \
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	--prefix=`pwd` \
	--with-pic=yes \
	--enable-static=yes \
	--enable-shared=no

make
make install

cd -
rm -rf $LIBNAME

}

Compile x86_64
