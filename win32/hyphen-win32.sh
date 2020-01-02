#!/bin/sh

SAVED_PATH=$PATH
LIBNAME="hyphen"

cd ../external/$LIBNAME
autoreconf -fvi
cd -

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

../../external/$LIBNAME/configure \
	CFLAGS="-g -Os -fPIC" \
	CPPFLAGS="-I`pwd`/../$1/include" \
	LDFLAGS="-L`pwd`/../$1/lib" \
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	--prefix=`pwd` \
	--enable-shared=no \
	--enable-static=yes

make
make install

cd -
rm -rf $LIBNAME

}

Compile x86_64
