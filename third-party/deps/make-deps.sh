#!/bin/sh

cd "$(dirname "$0")"
DIR=$PWD

if [ "$1" = "clean" ]; then
	test ! -d openssl-1.0.0t || (cd openssl-1.0.0t && make clean)
	test ! -d tiny-curl-7.72.0 || (cd tiny-curl-7.72.0 && make clean)
	exit 0
elif [ "$1" = "deepclean" ]; then
	rm -rf openssl-1.0.0t
	rm -rf tiny-curl-7.72.0
	exit 0
fi

if [ -z "$CROSS_COMPILE" ]; then
	echo "Error: CROSS_COMPILE not set."
	exit 1
fi

# if [ -z "$(autoconf --version 2> /dev/null)" ]; then
# 	echo "Error: autoconf is needed to build deps."
# 	echo '`apt-get update && apt-get install autoconf` to fix.'
# 	exit 1
# fi

# if [ -z "$(libtoolize --version 2> /dev/null)" ]; then
# 	echo "Error: libtool is needed to build deps."
# 	echo '`apt-get update && apt-get install libtool` to fix.'
# 	exit 1
# fi

export ARCH="arm"
# export CC="$CROSS_COMPILE""gcc"
unset CC
# export CXX="$CROSS_COMPILE""g++"
unset CXX
# export CPP="$CROSS_COMPILE""gcc -E"
unset CPP
# export STRIP="$CROSS_COMPILE""strip"
unset STRIP
# export AR="$CROSS_COMPILE""gcc-ar"
unset AR
# export RANLIB="$CROSS_COMPILE""gcc-ranlib"
unset RANLIB
export SYSROOT="$(${CROSS_COMPILE}gcc --print-sysroot)"
export CFLAGS="-Wall -Os -marm -march=armv7ve+simd -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard \
-ffunction-sections -fdata-sections -fno-unwind-tables -fno-asynchronous-unwind-tables -Wl,--gc-sections"
export CPPFLAGS="$CFLAGS -DNDEBUG"
export CXXFLAGS="$CFLAGS"
export SHARED="-fPIC"
export LDFLAGS="-Wl,-s -Wl,--gc-sections"

# openssl
if [ ! -f "openssl-1.0.0t/libssl.so.1.0.0" ] || [ ! -f "openssl-1.0.0t/libcrypto.so.1.0.0" ]; then
	test -d openssl-1.0.0t || tar xzf openssl-1.0.0t.tar.gz || exit $?
	cd openssl-1.0.0t || exit $?
	./configure shared linux-generic32 || exit $?
	make || exit $?
	cd ..
fi

# curl
if [ ! -f "tiny-curl-7.72.0/src/.libs/curl" ] || [ ! -f "tiny-curl-7.72.0/lib/.libs/libcurl.so.4.6.0" ]; then
	test -d tiny-curl-7.72.0 || tar xzf tiny-curl-7.72.0.tar.gz || exit $?
	cd tiny-curl-7.72.0 || exit $?

	LIBS="-lcrypto -lssl -lz" \
	CFLAGS="$CFLAGS -Wl,-rpath,$DIR/openssl-1.0.0t -I$DIR/openssl-1.0.0t/include" \
	CPPFLAGS="$CFLAGS -DNDEBUG" \
	CXXFLAGS="$CFLAGS" \
	LDFLAGS="$LDFLAGS -L$DIR/openssl-1.0.0t" \
	./configure --host=arm-linux-gnueabihf --target=arm-linux-gnueabihf \
	--enable-shared \
	--disable-static \
	--disable-cookies \
	--disable-crypto-auth \
	--disable-dict \
	--disable-file \
	--disable-ftp \
	--disable-gopher \
	--disable-imap \
	--disable-ldap \
	--disable-pop3 \
	--disable-proxy \
	--disable-rtmp \
	--disable-rtsp \
	--disable-scp \
	--disable-sftp \
	--disable-smtp \
	--disable-telnet \
	--disable-tftp \
	--disable-unix-sockets \
	--disable-verbose \
	--disable-versioned-symbols \
	--disable-http-auth \
	--disable-doh \
	--disable-mime \
	--disable-dateparse \
	--disable-netrc \
	--disable-dnsshuffle \
	--disable-progress-meter \
	--without-brotli \
	--without-gssapi \
	--without-libidn2 \
	--without-libmetalink \
	--without-libpsl \
	--without-librtmp \
	--without-libssh2 \
	--without-nghttp2 \
	--without-ntlm-auth \
	--with-ssl \
	--with-zlib \
	--with-openssl=$DIR/openssl-1.0.0t || exit $?

	make || exit $?
	cd ..
fi

exit 0
