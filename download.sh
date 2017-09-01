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
	wget http://download.sourceforge.net/libpng/libpng-1.6.32.tar.gz
	tar -xzf libpng-1.6.32.tar.gz
	rm libpng-1.6.32.tar.gz
	mv libpng-1.6.32 libpng
}

function get_mbedtls() {
	git clone https://github.com/ARMmbed/mbedtls.git --branch mbedtls-2.6.0 --single-branch
}

function get_curl() {
	wget https://curl.haxx.se/download/curl-7.55.1.tar.gz
	tar -xzf curl-7.55.1.tar.gz
	rm curl-7.55.1.tar.gz
	mv curl-7.55.1 curl
}

function get_freetype() {
	wget http://download.savannah.gnu.org/releases/freetype/freetype-2.8.tar.bz2
	tar -xjf freetype-2.8.tar.bz2
	rm freetype-2.8.tar.bz2
	mv freetype-2.8 freetype
}

function get_sqlite() {
	wget https://www.sqlite.org/2017/sqlite-amalgamation-3200100.zip
	unzip sqlite-amalgamation-3200100.zip -d .
	rm sqlite-amalgamation-3200100.zip
	mv sqlite-amalgamation-3200100 sqlite
}

function get_glfw() {
	wget https://github.com/glfw/glfw/releases/download/3.2.1/glfw-3.2.1.zip
	unzip glfw-3.2.1.zip -d .
	rm glfw-3.2.1.zip
	mv glfw-3.2.1 glfw
}

get_jpeg
get_png
get_mbedtls
get_curl
get_freetype
get_sqlite
get_glfw

cd -
