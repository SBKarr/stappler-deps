#!/bin/bash

SAVED_PATH=$PATH
LIBNAME="giflib"

Compile () {

PREFIX=`pwd`/$1

make -C ../src/$LIBNAME clean
make -C ../src/$LIBNAME CFLAGS="-Os -std=gnu99 -fPIC -Wall" CC=clang libgif.a

mv -f ../src/$LIBNAME/libgif.a $PREFIX/lib/libgif.a
cp -f ../src/$LIBNAME/gif_lib.h $PREFIX/include/gif_lib.h

}

Compile x86_64
