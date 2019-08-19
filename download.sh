#!/bin/bash

rm -rf src
mkdir src
cd src

function get_jpeg() {
	rm -rf jpeg
	wget http://ijg.org/files/jpegsrc.v9c.tar.gz
	tar -xzf jpegsrc.v9c.tar.gz
	mv jpeg-9c jpeg
	rm jpegsrc.v9c.tar.gz
}

function get_png() {
	rm -rf libpng
	wget http://prdownloads.sourceforge.net/libpng/libpng-1.6.37.tar.gz
	tar -xzf libpng-1.6.37.tar.gz
	rm libpng-1.6.37.tar.gz
	mv libpng-1.6.37 libpng
}

function get_gif() {
	rm -rf giflib
	wget https://sourceforge.net/projects/giflib/files/giflib-5.2.1.tar.gz
	tar -xzf giflib-5.2.1.tar.gz
	rm giflib-5.2.1.tar.gz
	mv giflib-5.2.1 giflib
}

function get_webp() {
	rm -rf libwebp
	wget https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.0.2.tar.gz
	tar -xzf libwebp-1.0.2.tar.gz
	rm libwebp-1.0.2.tar.gz
	mv libwebp-1.0.2 libwebp
}

function get_brotli() {
	rm -rf brotli
	git clone https://github.com/google/brotli.git  --branch v1.0.7 --single-branch
}

function get_mbedtls() {
	rm -rf mbedtls
	git clone https://github.com/ARMmbed/mbedtls.git --branch mbedtls-2.16.1 --single-branch
}

function get_curl() {
	rm -rf curl
	wget https://curl.haxx.se/download/curl-7.65.0.tar.gz
	tar -xzf curl-7.65.0.tar.gz
	rm curl-7.65.0.tar.gz
	mv curl-7.65.0 curl
}

function get_freetype() {
	rm -rf freetype
	wget https://download.savannah.gnu.org/releases/freetype/freetype-2.10.0.tar.bz2
	tar -xjf freetype-2.10.0.tar.bz2
	rm freetype-2.10.0.tar.bz2
	mv freetype-2.10.0 freetype
}

function get_sqlite() {
	rm -rf sqlite
	wget https://sqlite.org/2019/sqlite-amalgamation-3280000.zip
	unzip sqlite-amalgamation-3280000.zip -d .
	rm sqlite-amalgamation-3280000.zip
	mv sqlite-amalgamation-3280000 sqlite
}

function get_glfw() {
	rm -rf glfw
	wget https://github.com/glfw/glfw/releases/download/3.3/glfw-3.3.zip
	unzip glfw-3.3.zip -d .
	rm glfw-3.3.zip
	mv glfw-3.3 glfw
}

function get_libidn2 {
	wget ftp://ftp.gnu.org/gnu/libidn/libidn2-2.2.0.tar.gz
	tar -xzf libidn2-2.2.0.tar.gz
	rm libidn2-2.2.0.tar.gz
	mv libidn2-2.2.0 libidn2
}

get_jpeg
get_png
get_gif
get_webp
get_brotli
get_mbedtls
get_curl
get_freetype
get_sqlite
get_glfw
get_libidn2

cd -
