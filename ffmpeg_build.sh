#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd ffmpeg

make clean
rm -f compat/*.o compat/*.d

# ./configure \
# --target-os="$TARGET_OS" \
# --cross-prefix="$CROSS_PREFIX" \
# --arch="$NDK_ARCH" \
# --cpu="$CPU" \
# --enable-runtime-cpudetect \
# --sysroot="$NDK_SYSROOT" \
# --enable-pic \
# --enable-libx264 \
# --enable-libass \
# --enable-libfreetype \
# --enable-libfribidi \
# --enable-libmp3lame \
# --enable-fontconfig \
# --enable-pthreads \
# --disable-debug \
# --disable-ffserver \
# --enable-version3 \
# --enable-hardcoded-tables \
# --disable-ffplay \
# --disable-ffprobe \
# --enable-gpl \
# --enable-yasm \
# --disable-doc \
# --disable-shared \
# --enable-static \
# --pkg-config="${2}/ffmpeg-pkg-config" \
# --prefix="${2}/build/${1}" \
# --extra-cflags="-I${TOOLCHAIN_PREFIX}/include $CFLAGS" \
# --extra-ldflags="-L${TOOLCHAIN_PREFIX}/lib $LDFLAGS" \
# --extra-libs="-lpng -lexpat -lm" \
# --extra-cxxflags="$CXX_FLAGS" || exit 1

./configure \
--target-os="$TARGET_OS" \
--cross-prefix="$CROSS_PREFIX" \
--enable-cross-compile \
--arch="$NDK_ARCH" \
--sysroot="$NDK_SYSROOT" \
--disable-muxers \
--enable-muxer=mp4 \
--disable-demuxers \
--enable-demuxer=mov \
--disable-decoders \
--enable-decoder=h264 \
--enable-decoder=aac \
--enable-decoder=amr_nb \
--enable-decoder=mpeg4 \
--disable-encoders \
--enable-encoder=aac \
--disable-hwaccels \
--disable-protocols \
--disable-filters \
--enable-filter=scale \
--enable-filter=aresample \
--enable-filter=fps \
--enable-pic \
--enable-libx264 \
--disable-debug \
--disable-ffserver \
--disable-avdevice \
--enable-version3 \
--disable-ffplay \
--disable-ffprobe \
--enable-gpl \
--disable-doc \
--disable-shared \
--enable-static \
--pkg-config="${2}/ffmpeg-pkg-config" \
--extra-cflags="$CFLAGS" \
--extra-ldflags="$LDFLAGS" \
--prefix="${2}/build/${1}" || exit 1

make -j6 && make install || exit 1

popd
