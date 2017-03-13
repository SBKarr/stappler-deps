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
	wget http://prdownloads.sourceforge.net/libpng/libpng-1.6.26.tar.gz
	tar -xzf libpng-1.6.26.tar.gz
	rm libpng-1.6.26.tar.gz
	mv libpng-1.6.26 libpng
}

function get_mbedtls() {
	git clone https://github.com/ARMmbed/mbedtls.git --branch mbedtls-2.4.1 --single-branch
}

function get_curl() {
	wget https://curl.haxx.se/download/curl-7.51.0.tar.gz
	tar -xzf curl-7.51.0.tar.gz
	rm curl-7.51.0.tar.gz
	mv curl-7.51.0 curl
}

function get_freetype() {
	wget http://ftp.acc.umu.se/mirror/gnu.org/savannah//freetype/freetype-2.7.tar.gz
	tar -xzf freetype-2.7.tar.gz
	rm freetype-2.7.tar.gz
	mv freetype-2.7 freetype
}

function get_sqlite() {
	wget https://www.sqlite.org/2016/sqlite-amalgamation-3140000.zip
	unzip sqlite-amalgamation-3140000.zip -d .
	rm sqlite-amalgamation-3140000.zip
	mv sqlite-amalgamation-3140000 sqlite
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
get_pixman
get_cairo
get_freetype
get_sqlite
get_glfw

cd -
