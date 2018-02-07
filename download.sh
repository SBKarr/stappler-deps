#!/bin/bash

rm -rf src
mkdir src
cd src

function get_jpeg() {
	wget http://ijg.org/files/jpegsrc.v9c.tar.gz
	tar -xzf jpegsrc.v9c.tar.gz
	mv jpeg-9c jpeg
	rm jpegsrc.v9c.tar.gz
}

function get_png() {
	wget https://download.sourceforge.net/libpng/libpng-1.6.34.tar.gz
	tar -xzf libpng-1.6.34.tar.gz
	rm libpng-1.6.34.tar.gz
	mv libpng-1.6.34 libpng
}

function get_webp() {
	wget https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-0.6.1.tar.gz
	tar -xzf libwebp-0.6.1.tar.gz
	rm libwebp-0.6.1.tar.gz
	mv libwebp-0.6.1 libwebp
}

function get_brotli() {
	wget https://github.com/google/brotli/archive/v1.0.2.tar.gz
	tar -xzf v1.0.2.tar.gz
	rm v1.0.2.tar.gz
	mv brotli-1.0.2 brotli
}

function get_mbedtls() {
	git clone https://github.com/ARMmbed/mbedtls.git --branch mbedtls-2.7.0 --single-branch
}

function get_curl() {
	wget https://curl.haxx.se/download/curl-7.58.0.tar.gz
	tar -xzf curl-7.58.0.tar.gz
	rm curl-7.58.0.tar.gz
	mv curl-7.58.0 curl
}

function get_freetype() {
	wget https://download.savannah.gnu.org/releases/freetype/freetype-2.9.tar.bz2
	tar -xjf freetype-2.9.tar.bz2
	rm freetype-2.9.tar.bz2
	mv freetype-2.9 freetype
}

function get_sqlite() {
	wget https://sqlite.org/2018/sqlite-amalgamation-3220000.zip
	unzip sqlite-amalgamation-3220000.zip -d .
	rm sqlite-amalgamation-3220000.zip
	mv sqlite-amalgamation-3220000 sqlite
}

function get_glfw() {
	wget https://github.com/glfw/glfw/releases/download/3.2.1/glfw-3.2.1.zip
	unzip glfw-3.2.1.zip -d .
	rm glfw-3.2.1.zip
	mv glfw-3.2.1 glfw
}

get_jpeg
get_png
get_webp
get_brotli
get_mbedtls
get_curl
get_freetype
get_sqlite
get_glfw

cd -
