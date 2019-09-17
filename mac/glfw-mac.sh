#!/bin/bash

SAVED_PATH=$PATH

VERSION="10.14"

Compile () {

export MACOSX_DEPLOYMENT_TARGET=$VERSION

mkdir -p glfw
cd glfw

export CC="clang"
export CPP="clang -E"
export CFLAGS="-Os -fPIC -mmacosx-version-min=$VERSION"

cmake ../../src/glfw

make CC="clang" CFLAGS="-Os -fPIC" glfw
cp -f src/libglfw3.a ../$1/lib/
cp -f ../../src/glfw/include/GLFW/* ../$1/include/

cd -
rm -rf glfw

}

Compile x86_64
