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

# Debug/Release specific configurations
if (CMAKE_CONFIGURATION_TYPES)
    set_target_properties(opencv_test PROPERTIES
        DEBUG_POSTFIX "d"
    )
endif()

# Cross-compilation and platform-specific settings
if (CMAKE_SYSTEM_NAME STREQUAL "Linux" AND CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
    message(STATUS "Targeting Raspberry Pi ARM64")
endif()
