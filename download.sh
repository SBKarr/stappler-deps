#!/bin/bash

rm -rf src
mkdir src
cd src

function get_jpeg() {
	wget http://www.ijg.org/files/jpegsrc.v9b.tar.gz
	tar -xzf jpegsrc.v9b.tar.gz
	mv jpeg-9b jpeg
	rm jpegsrc.v9b.tar.gz
}

function get_png() {
	wget http://download.sourceforge.net/libpng/libpng-1.6.28.tar.gz
	tar -xzf libpng-1.6.28.tar.gz
	rm libpng-1.6.28.tar.gz
	mv libpng-1.6.28 libpng
}

function get_mbedtls() {
	git clone https://github.com/ARMmbed/mbedtls.git --branch mbedtls-2.4.2 --single-branch
}

function get_curl() {
	wget https://curl.haxx.se/download/curl-7.53.1.tar.gz
	tar -xzf curl-7.53.1.tar.gz
	rm curl-7.53.1.tar.gz
	mv curl-7.53.1 curl
}

function get_freetype() {
	wget http://download.savannah.gnu.org/releases/freetype/freetype-2.7.1.tar.gz
	tar -xzf freetype-2.7.1.tar.gz
	rm freetype-2.7.1.tar.gz
	mv freetype-2.7.1 freetype
}

function get_sqlite() {
	wget https://www.sqlite.org/2017/sqlite-amalgamation-3170000.zip
	unzip sqlite-amalgamation-3170000.zip -d .
	rm sqlite-amalgamation-3170000.zip
	mv sqlite-amalgamation-3170000 sqlite
}

function get_glfw() {
	wget https://github.com/glfw/glfw/releases/download/3.2/glfw-3.2.zip
	unzip glfw-3.2.zip -d .
	rm glfw-3.2.zip
	mv glfw-3.2 glfw
}

get_jpeg
get_png
get_mbedtls
get_curl
get_freetype
get_sqlite
get_glfw

cd -
