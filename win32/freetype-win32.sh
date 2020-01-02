#!/bin/sh

SAVED_PATH=$PATH

Compile () {

mkdir -p freetype
cd freetype

../../src/freetype/configure --host=$1-w64-mingw32 \
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	--with-bzip2=no \
	--with-zlib=yes \
	--with-png=yes \
	--with-harfbuzz=no \
	--with-pic=yes \
	--enable-static=yes \
	--enable-shared=no \
	LIBPNG_CFLAGS="-I`pwd`/../$1/include" \
	LIBPNG_LIBS="-L`pwd`/../$1/lib -lpng -lz"
	PKG_CONFIG_PATH="`pwd`/../$1/lib/pkgconfig" \
	CPPFLAGS="-I`pwd`/../$1/include" \
	LDFLAGS="-L`pwd`/../$1/lib" \
	--prefix=`pwd`

#make

#echo "Try to replace apinames tools with Cygwin alternative"
#rm apinames.exe
#/usr/bin/gcc  -o apinames.exe ../../src/freetype/src/tools/apinames.c

make
make install

cd -
rm -rf freetype

cp -rf $1/include/freetype2/* $1/include
rm -rf $1/include/freetype2

}

Compile x86_64
