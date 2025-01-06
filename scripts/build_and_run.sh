#!/bin/bash

set -e

# Clean
if [[ "$1" == "clean" ]]; then
    echo "[INFO] Cleaning build directory..."
    rm -rf build
    mkdir build
    cd build
    cmake ..
    exit
fi

# Debug Build
if [[ "$1" == "debug" ]]; then
    echo "[INFO] Building in Debug mode..."
    mkdir -p build && cd build
    cmake -DCMAKE_BUILD_TYPE=Debug ..
    cmake --build .
    if [[ -f ./opencv_test ]]; then
        echo "[INFO] Running Debug build..."
        ./opencv_test
    else
        echo "[ERROR] Debug executable not found."
        exit 1
    fi
    exit
fi

# Release Build
if [[ "$1" == "release" ]]; then
    echo "[INFO] Building in Release mode..."
    mkdir -p build && cd build
    cmake -DCMAKE_BUILD_TYPE=Release ..
    cmake --build .
    if [[ -f ./opencv_test ]]; then
        echo "[INFO] Running Release build..."
        ./opencv_test
    else
        echo "[ERROR] Release executable not found."
        exit 1
    fi
    exit
fi

# Cross-compile
if [[ "$1" == "cross" ]]; then
    echo "[INFO] Cross-compiling for Raspberry Pi..."
    mkdir -p build && cd build
    cmake -DCMAKE_TOOLCHAIN_FILE=../toolchains/toolchain-raspi.cmake -DCMAKE_BUILD_TYPE=Release ..
    cmake --build .
    echo "[INFO] Cross-compilation completed successfully."
    exit
fi

# Default Case
echo "[ERROR] Usage: ./build_and_run.sh clean|debug|release|cross"
exit 1
