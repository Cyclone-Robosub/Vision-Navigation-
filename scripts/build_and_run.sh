#!/bin/bash
if [[ "$1" == "debug" || "$1" == "release" ]]; then
    mkdir -p build && cd build || exit
    cmake -DCMAKE_BUILD_TYPE="$(echo "$1" | tr '[:lower:]' '[:upper:]')" ..
    cmake --build .
    ./opencv_test
    exit
fi

echo "[ERROR] Usage: ./build_and_run.sh debug|release"
exit 1
