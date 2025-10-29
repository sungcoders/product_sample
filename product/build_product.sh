#!/bin/bash

# import common functions
SOURCE_DIR="$(dirname "$0")"
source "$SOURCE_DIR/common/scripts/common.sh"

# config build
BUILD_DIR="build"
BUILD_TYPE="Release"

# sysroot
# SYSROOT_PATH="/path/to/sysroot"
# CMAKE_SYSROOT_ARG="-DCMAKE_SYSROOT=$SYSROOT_PATH"

# folder build
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
cd $BUILD_DIR

echo "[CMake] cross compile build project..."
cmake .. \
    -DCMAKE_TOOLCHAIN_FILE=../common/cmake/toolchain-arm.cmake \
    -DCMAKE_BUILD_TYPE=BUILD_TYPE \
    -DCMAKE_C_COMPILER=$CMAKE_C_COMPILER \
    -DCMAKE_CXX_COMPILER=$CMAKE_CXX_COMPILER \
    -DCMAKE_CXX_STANDARD=17

echo "[CMake] Building..."
cmake --build . -j$(nproc)

echo "✅ Build done!"

