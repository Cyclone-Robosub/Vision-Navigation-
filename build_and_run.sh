#!/bin/bash

# create directory if not existant 
if [ ! -d "build" ]; then
    mkdir build
fi

cmake -B build # configure project
cmake --build build # build project
./build/opencv_test # run executable