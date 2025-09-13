#!/bin/bash

# ============================
# Script build project bằng CMake
# ============================

# Tên thư mục build (có thể thay đổi)
BUILD_DIR="build"

# =============================
# functions helper
# =============================
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
# =============================
# Parse options
# =============================
while getopts "hbcm:" opt; do
    FLAG_USED=true
    case $opt in
        h)
            show_help
            exit 0
            ;;
        b)
            build_target
            exit 0
            ;;
        c)
            echo "🧹 Cleaning build directory..."
            rm -rf "$BUILD_DIR"
            exit 0
            ;;
        m)
            echo " TBD: Run tests with option -m $OPTARG"
            exit 0
            ;;
        *)
            show_help
            exit 0
            ;;
    esac
done

#default show help if no option
show_help
