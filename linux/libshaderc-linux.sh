#!/bin/sh

SAVED_PATH=$PATH

Compile () {

mkdir -p libshaderc
cd libshaderc

export CC=gcc

cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ../../src/shaderc

make shaderc

cd -

}

Compile x86_64
