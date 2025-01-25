cmake_minimum_required(VERSION 3.10)
project(OpenCV_Test)

# Find OpenCV
find_package(OpenCV REQUIRED)

# Source files
add_executable(opencv_test src/main.cpp src/utils.cpp)

# Include directories
target_include_directories(opencv_test PRIVATE include ${OpenCV_INCLUDE_DIRS})

# Link libraries
target_link_libraries(opencv_test PRIVATE ${OpenCV_LIBS})
