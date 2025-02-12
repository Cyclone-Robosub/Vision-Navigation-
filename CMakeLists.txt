cmake_minimum_required(VERSION 3.0)
project(OpenCV_vision)

# Find OpenCV
find_package(OpenCV REQUIRED)

# Include directories
include_directories(${OpenCV_INCLUDE_DIRS})

# Source files
add_executable(OpenCV_vision src/main.cpp)

# Link libraries
target_link_libraries(OpenCV_vision ${OpenCV_LIBS})
