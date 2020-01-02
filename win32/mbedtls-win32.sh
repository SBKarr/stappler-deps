#!/bin/bash

SAVED_PATH=$PATH

Compile () {

rm -f library/libmbed*

make -C ../src/mbedtls clean
make -C ../src/mbedtls CFLAGS="-O3" CC=gcc lib

mkdir -p `pwd`/$1/include `pwd`/$1/lib

cp -r ../src/mbedtls/include/mbedtls `pwd`/$1/include
cp -RP ../src/mbedtls/library/libmbed* `pwd`/$1/lib

}

Compile x86_64
