#!/bin/sh

SAVED_PATH=$PATH
LIBNAME="freetype"

VERSION="10.14"

Compile () {

export MACOSX_DEPLOYMENT_TARGET=$VERSION

mkdir -p $LIBNAME
cd $LIBNAME

../../src/$LIBNAME/configure \
	CC="clang" CFLAGS="-Os -fPIC -mmacosx-version-min=$VERSION" \
	CPP="clang -E" CPPFLAGS="-I`pwd`/../$1/include -mmacosx-version-min=$VERSION" \
	LDFLAGS="-L`pwd`/../$1/lib -mmacosx-version-min=$VERSION" \
	PKG_CONFIG_PATH="`pwd`/../$1/lib/pkgconfig" \
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	--prefix=`pwd` \
	--with-bzip2=no \
	--with-zlib=yes \
	--with-png=yes \
	--with-harfbuzz=no \
	--with-pic=yes \
	--enable-static=yes \
	--enable-shared=no

make
make install

cd -
rm -rf $LIBNAME

cp -rf $1/include/freetype2/* $1/include
rm -rf $1/include/freetype2

}

Compile x86_64
