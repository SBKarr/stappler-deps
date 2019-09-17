#!/bin/sh

SAVED_PATH=$PATH
LIBNAME="hyphen"

VERSION="10.14"

cd ../external/$LIBNAME
autoreconf -fvi
cd -

Compile () {

export MACOSX_DEPLOYMENT_TARGET=$VERSION

mkdir -p $LIBNAME
cd $LIBNAME

../../external/$LIBNAME/configure \
	CC="clang" CFLAGS="-g -Os -fPIC -mmacosx-version-min=$VERSION" \
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

}

Compile x86_64
