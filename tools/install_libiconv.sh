#/usr/bin/env bash

set -e

# prepare Android ndk
if [ ! -f android-ndk-r16b.zip ]; then
  wget -q --output-document=android-ndk-r16b.zip \
    https://dl.google.com/android/repository/android-ndk-r16b-linux-x86_64.zip
fi
unzip android-ndk-r16b.zip
`pwd`/android-ndk-r16b/build/tools/make_standalone_toolchain.py --arch arm64 --api 21 \
  --stl=libc++ --install-dir `pwd`/my-android-toolchain8
export ANDROID_TOOLCHAIN_PATH=`pwd`/my-android-toolchain8
export PATH=${ANDROID_TOOLCHAIN_PATH}/bin:$PATH

# cross compile libiconv
if [ ! -f libiconv-1.15.tar.gz ]; then
  curl -O -L https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
fi
tar xzf libiconv-1.15.tar.gz
cd libiconv-1.15
CFLAGS="$CFLAGS -D__ANDROID_API__=21"  ./configure \
  --host=aarch64-linux-android --with-sysroot=$ANDROID_TOOLCHAIN_PATH/sysroot \
  --enable-shared=no --enable-static=yes --prefix=`pwd`/install
make
make install
