#!/bin/bash

function build() {
	cd linux
	./jpeg-linux.sh
	./libpng-linux.sh
	./gif-linux.sh
	./libwebp-linux.sh
	./brotli-linux.sh
	./mbedtls-linux.sh
	./libidn2-linux.sh
	./curl-linux.sh
	./freetype-linux.sh
	./sqlite-linux.sh
	./glfw-linux.sh
	./hyphen-linux.sh
	cd -
}

if [ -z "$1" ]; then
build
fi
