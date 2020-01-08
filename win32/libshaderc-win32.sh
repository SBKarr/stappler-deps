#!/bin/sh

SAVED_PATH=$PATH

Compile () {

mkdir -p libshaderc
cd libshaderc

export CC=gcc
export WIN32=1

#rm -f library/libmbed*

cmake -G "MSYS Makefiles" -DCMAKE_BUILD_TYPE=Release ../../src/shaderc

make libshaderc
#cp -f src/libglfw3.a ../$1/lib/
#cp -f ../../src/glfw/include/GLFW/* ../$1/include/

cd -
# rm -rf glfw

}

Compile x86_64
