#!/bin/sh

SAVED_PATH=$PATH
LIBNAME="libidn2"

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
	--with-pic=yes \
	--enable-static=yes \
	--enable-shared=no \
	--without-libunistring \
    --without-libunistring-prefix

make
make install

cd -
rm -rf $LIBNAME

}

Compile x86_64
