#!/bin/sh

mkdir build && cd build

cmake  ${CMAKE_ARGS} $SRC_DIR
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON

make -j${CPU_COUNT}
make install
