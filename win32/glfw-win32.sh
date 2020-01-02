#!/bin/bash

SAVED_PATH=$PATH

Compile () {

mkdir -p glfw
cd glfw

export CC=gcc
export WIN32=1

rm -f library/libmbed*

cmake -G "MSYS Makefiles" ../../src/glfw

make glfw
cp -f src/libglfw3.a ../$1/lib/
cp -f ../../src/glfw/include/GLFW/* ../$1/include/

cd -
rm -rf glfw

}

Compile x86_64
