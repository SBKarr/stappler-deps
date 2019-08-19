#!/bin/bash

if [ -z "$ANDROID_NDK_ROOT" ]; then
NDK="/home/sbkarr/android/ndk"
else
NDK="$ANDROID_NDK_ROOT"
fi

function build() {
	export ANDROID_NDK_ROOT=$NDK

	cd android
	./jpeg-android.sh
	./libpng-android.sh
	./gif-android.sh
	./libwebp-android.sh
	./brotli-android.sh
	./mbedtls-android.sh
	./libidn2-android.sh
	./curl-android.sh
	./freetype-android.sh
	./sqlite-android.sh
	./hyphen-android.sh
	cd -
}

if [ -z "$1" ]; then
make_toolchains
build
fi
