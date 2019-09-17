#!/bin/sh

SAVED_PATH=$PATH
LIBNAME="libpng"

VERSION="10.14"

Compile () {

export MACOSX_DEPLOYMENT_TARGET=$VERSION

mkdir -p $LIBNAME
cd $LIBNAME

../../src/$LIBNAME/configure \
	CC="clang" CFLAGS="-Os -fPIC -mmacosx-version-min=$VERSION" \
	CPP="clang -E" CPPFLAGS="-I`pwd`/../$1/include -mmacosx-version-min=$VERSION" \
	LDFLAGS="-L`pwd`/../$1/lib -mmacosx-version-min=$VERSION" \
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	--prefix=`pwd` \
	--enable-shared=no \
	--enable-static=yes

make
make install

cd -
rm -rf $LIBNAME

rm $1/include/png.h $1/include/pngconf.h $1/include/pnglibconf.h
cp -f $1/include/libpng16/* $1/include
rm -rf $1/include/libpng16
rm $1/lib/libpng.a
rm $1/lib/libpng.la
mv -f $1/lib/libpng16.a $1/lib/libpng.a
mv -f $1/lib/libpng16.la $1/lib/libpng.la

}

Compile x86_64
