#!/bin/sh

if [[ "${target_platform}" == osx-* ]]; then
    # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

mkdir build && cd build

cmake ${CMAKE_ARGS} $SRC_DIR \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CROSSCOMPILING=$CONDA_BUILD_CROSS_COMPILATION \
      -DCMAKE_CROSSCOMPILING_EMULATOR=$CONDA_BUILD_CROSS_COMPILATION \
      -DBUILD_SHARED_LIBS=ON

make -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  make check
fi
make install
