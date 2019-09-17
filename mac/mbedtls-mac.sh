#!/bin/bash

SAVED_PATH=$PATH

VERSION="10.14"

Compile () {

export MACOSX_DEPLOYMENT_TARGET=$VERSION

rm -f library/libmbed*

make -C ../src/mbedtls clean
make -C ../src/mbedtls CFLAGS="-Os -fPIC -mmacosx-version-min=$VERSION" CC=clang lib

cp -r ../src/mbedtls/include/mbedtls `pwd`/$1/include
cp -RP ../src/mbedtls/library/libmbed* `pwd`/$1/lib

}

Compile x86_64
