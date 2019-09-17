#!/bin/bash

SAVED_PATH=$PATH

VERSION="10.14"

Compile () {

export MACOSX_DEPLOYMENT_TARGET=$VERSION

mkdir -p sqlite
cd sqlite

clang -Os -fPIC  -mmacosx-version-min=$VERSION -c -o sqlite3.o ../../src/sqlite/sqlite3.c
ar rcs libsqlite3.a sqlite3.o

mv -f libsqlite3.a ../$1/lib/
cp -f ../../src/sqlite/*.h ../$1/include/

cd -
rm -rf sqlite

}

Compile x86_64
