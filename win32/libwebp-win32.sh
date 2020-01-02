#!/bin/sh

SAVED_PATH=$PATH
LIBNAME="libwebp"

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
	--enable-shared=no \
	--enable-static=yes \
	--enable-png \
	--with-pnglibdir=`pwd`/../$1/lib \
	--with-pngincludedir=`pwd`/../$1/include \
	--disable-gl \
	--disable-sdl \
	--disable-tiff \
	--disable-gif \
	--disable-wic

make
make install

cd -
rm -rf $LIBNAME

}

Compile x86_64
