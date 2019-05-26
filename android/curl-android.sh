#!/bin/bash
# Android/ARM, armeabi (ARMv5TE soft-float), Android 2.2+ (Froyo)

if [ -z "$ANDROID_NDK_ROOT" ]; then
NDK="/home/sbkarr/android/ndk"
else
NDK="$ANDROID_NDK_ROOT"
fi

CFLAGS="-Os"
LIBNAME=curl
ROOT=`pwd`

Compile () {

mkdir -p $LIBNAME
cd $LIBNAME

NDKP=$2
TARGET=$3

NDKF="$CFLAGS"
NDKARCH=$4
NDKLDFLAGS=$5

../../src/$LIBNAME/configure \
	CC=$NDKP-clang CFLAGS="$NDKF $NDKARCH" \
	LD=$NDKP-ld LDFLAGS="$NDKLDFLAGS" \
	--host=$TARGET --with-sysroot="$TOOLCHAIN/sysroot" \
	CPPFLAGS="-I`pwd`/../$1/include" \
	LDFLAGS="-L`pwd`/../$1/lib" \
	PKG_CONFIG_PATH="`pwd`/../$1/lib/pkgconfig" \
	--disable-optimize \
	--disable-warnings \
	--disable-curldebug \
	--enable-symbol-hiding \
	--disable-largefile \
	--enable-http \
	--enable-ftp \
	--enable-file \
	--disable-ldap \
	--disable-ldaps \
	--disable-rtsp \
	--disable-proxy \
	--disable-dict \
	--disable-telnet \
	--disable-tftp \
	--disable-pop3 \
	--disable-imap \
	--disable-smb \
	--disable-smtp \
	--disable-gopher \
	--disable-manual \
	--enable-ipv6 \
	--disable-versioned-symbols \
	--disable-verbose  \
	--disable-sspi \
	--disable-ntlm-wb  \
	--disable-unix-sockets \
	--enable-cookies \
	--enable-shared=no \
	--enable-static=yes \
	--enable-pthreads \
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	--prefix=`pwd` \
	--with-zlib \
	--with-brotli \
	--with-mbedtls \
	--with-libidn2 \
	--without-ca-path \
	--without-ca-fallback \
	--without-ca-bundle \
	--without-libmetalink \
	--without-libssh2
make
make install

cd -
rm -rf $LIBNAME

}

NDKPATH=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin

Compile armeabi-v7a $NDKPATH/armv7a-linux-androideabi19  arm-linux-androideabi '-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16' '-march=armv7-a -Wl,--fix-cortex-a8'
Compile	x86         $NDKPATH/i686-linux-android19    i686-linux-android	  '' ''
Compile	arm64-v8a   $NDKPATH/aarch64-linux-android21 aarch64-linux-android '' ''
Compile	x86_64      $NDKPATH/x86_64-linux-android21  x86_64-linux-android  '' ''
