#!/bin/bash

SAVED_PATH=$PATH

Compile () {

mkdir -p curl
cd curl

export PATH="/usr/bin/$1-w64-mingw32:$SAVED_PATH"

../../src/curl/configure --host=$1-w64-mingw32 \
	CFLAGS="-Os -fPIC" \
	CPPFLAGS="-I`pwd`/../$1/include" \
	LDFLAGS="-L`pwd`/../$1/lib" \
	PKG_CONFIG_PATH="`pwd`/../$1/lib/pkgconfig" \
	--includedir=`pwd`/../$1/include \
	--libdir=`pwd`/../$1/lib \
	--prefix=`pwd` \
	--disable-optimize \
	--disable-warnings \
	--disable-curldebug \
	--enable-symbol-hiding \
	--disable-largefile \
	--enable-http \
	--enable-ftp \
	--enable-file \
	--enable-smtp \
	--enable-proxy \
	--disable-ldap \
	--disable-ldaps \
	--disable-rtsp \
	--disable-dict \
	--disable-telnet \
	--disable-tftp \
	--disable-pop3 \
	--disable-imap \
	--disable-smb \
	--disable-gopher \
	--disable-manual \
	--disable-rtmp \
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
	--with-zlib \
	--with-brotli \
	--with-winssl \
	--with-winidn \
	--without-ca-path \
	--without-ca-fallback \
	--without-ca-bundle \
	--without-libmetalink \
	--without-libssh2 \
	--without-libidn \
	--without-libidn2 \
	--without-ssl \
	--without-librtmp \
	--without-nghttp2 \
	--without-libpsl

make
make install
make install-data

cd -
rm -rf curl

}

Compile x86_64
