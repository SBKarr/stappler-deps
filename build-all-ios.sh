#!/bin/bash

function build() {
	cd ios
	./jpeg-ios.sh
	./libpng-ios.sh
	./libwebp-ios.sh
	./brotli-ios.sh
	./curl-ios.sh
	./freetype-ios.sh
	./hyphen-ios.sh
	./libidn2-ios.sh
	cd -
}


build
