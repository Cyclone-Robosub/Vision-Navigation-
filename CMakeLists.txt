cmake_minimum_required(VERSION 3.0)
project(OpenCV_Test)

# Find OpenCV
find_package(OpenCV REQUIRED)

# Include directories
include_directories(${OpenCV_INCLUDE_DIRS})

# Source files
add_executable(opencv_test src/main.cpp)

# Link libraries
target_link_libraries(opencv_test ${OpenCV_LIBS})
