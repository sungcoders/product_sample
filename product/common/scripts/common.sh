#!/bin/bash

show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

OPTIONS:
  -h        Help
  -b        Build project
  -c        Clean build directory
  -m <arg>  Run tests with option <arg>

Examples:
  $0 -b     # build project
  $0 -c     # clean build directory
EOF
}

build_target() {
    mkdir -p "$BUILD_DIR"
    echo "⚙️  Configuring project..."
    cmake -S . -B "$BUILD_DIR"
    echo "🔨 Building project..."
    cmake --build "$BUILD_DIR" -j$(nproc)
    echo "✅ Build finished! Binaries are inside: $BUILD_DIR"
}

