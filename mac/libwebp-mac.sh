#!/bin/sh

SAVED_PATH=$PATH
LIBNAME="libwebp"

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

../../src/$LIBNAME/configure \
	CC="clang" CFLAGS="-Os -fPIC" \
	CPP="clang -E" CPPFLAGS="-I`pwd`/../$1/include" \
	LDFLAGS="-L`pwd`/../$1/lib" \
	PKG_CONFIG_PATH="`pwd`/../$1/lib/pkgconfig" \
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	--prefix=`pwd` \
	--enable-shared=no \
	--enable-static=yes \
	--disable-gl \
	--disable-sdl \
	--disable-png \
	--disable-jpeg \
	--disable-tiff \
	--disable-gif \
	--disable-wic

make
make install

cd -
rm -rf $LIBNAME

}

Compile x86_64
