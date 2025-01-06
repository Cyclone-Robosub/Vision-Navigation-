#!/bin/bash

set -e

# Clean
if [[ "$1" == "clean" ]]; then
    echo "🧹 Cleaning build directory..."
    rm -rf build
    mkdir build
    cd build
    cmake ..
    exit
fi

# Debug Build
if [[ "$1" == "debug" ]]; then
    echo "🐞 Building in Debug mode..."
    mkdir -p build && cd build
    cmake -DCMAKE_BUILD_TYPE=Debug ..
    cmake --build .
    ./opencv_test
    exit
fi

# Release Build
if [[ "$1" == "release" ]]; then
    echo "🔨 Building in Release mode..."
    mkdir -p build && cd build
    cmake -DCMAKE_BUILD_TYPE=Release ..
    cmake --build .
    ./opencv_test
    exit
fi

# Cross-compile
if [[ "$1" == "cross" ]]; then
    echo "🌐 Cross-compiling for Raspberry Pi..."
    mkdir -p build && cd build
    cmake -DCMAKE_TOOLCHAIN_FILE=../toolchains/toolchain-raspi.cmake -DCMAKE_BUILD_TYPE=Release ..
    cmake --build .
    echo "✅ Cross-compilation completed."
    exit
fi

echo "⚠️ Usage: ./build_and_run.sh clean|debug|release|cross"
exit 1

