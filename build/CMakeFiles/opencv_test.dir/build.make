# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/robosub/navigation

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/robosub/navigation/build

# Include any dependencies generated for this target.
include CMakeFiles/opencv_test.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/opencv_test.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/opencv_test.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/opencv_test.dir/flags.make

CMakeFiles/opencv_test.dir/src/main.cpp.o: CMakeFiles/opencv_test.dir/flags.make
CMakeFiles/opencv_test.dir/src/main.cpp.o: /home/robosub/navigation/src/main.cpp
CMakeFiles/opencv_test.dir/src/main.cpp.o: CMakeFiles/opencv_test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/robosub/navigation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/opencv_test.dir/src/main.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/opencv_test.dir/src/main.cpp.o -MF CMakeFiles/opencv_test.dir/src/main.cpp.o.d -o CMakeFiles/opencv_test.dir/src/main.cpp.o -c /home/robosub/navigation/src/main.cpp

CMakeFiles/opencv_test.dir/src/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/opencv_test.dir/src/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/robosub/navigation/src/main.cpp > CMakeFiles/opencv_test.dir/src/main.cpp.i

CMakeFiles/opencv_test.dir/src/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/opencv_test.dir/src/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/robosub/navigation/src/main.cpp -o CMakeFiles/opencv_test.dir/src/main.cpp.s

CMakeFiles/opencv_test.dir/src/utils.cpp.o: CMakeFiles/opencv_test.dir/flags.make
CMakeFiles/opencv_test.dir/src/utils.cpp.o: /home/robosub/navigation/src/utils.cpp
CMakeFiles/opencv_test.dir/src/utils.cpp.o: CMakeFiles/opencv_test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/robosub/navigation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/opencv_test.dir/src/utils.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/opencv_test.dir/src/utils.cpp.o -MF CMakeFiles/opencv_test.dir/src/utils.cpp.o.d -o CMakeFiles/opencv_test.dir/src/utils.cpp.o -c /home/robosub/navigation/src/utils.cpp

CMakeFiles/opencv_test.dir/src/utils.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/opencv_test.dir/src/utils.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/robosub/navigation/src/utils.cpp > CMakeFiles/opencv_test.dir/src/utils.cpp.i

CMakeFiles/opencv_test.dir/src/utils.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/opencv_test.dir/src/utils.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/robosub/navigation/src/utils.cpp -o CMakeFiles/opencv_test.dir/src/utils.cpp.s

# Object files for target opencv_test
opencv_test_OBJECTS = \
"CMakeFiles/opencv_test.dir/src/main.cpp.o" \
"CMakeFiles/opencv_test.dir/src/utils.cpp.o"

# External object files for target opencv_test
opencv_test_EXTERNAL_OBJECTS =

opencv_test: CMakeFiles/opencv_test.dir/src/main.cpp.o
opencv_test: CMakeFiles/opencv_test.dir/src/utils.cpp.o
opencv_test: CMakeFiles/opencv_test.dir/build.make
opencv_test: /usr/local/lib/libopencv_gapi.so.4.10.0
opencv_test: /usr/local/lib/libopencv_highgui.so.4.10.0
opencv_test: /usr/local/lib/libopencv_ml.so.4.10.0
opencv_test: /usr/local/lib/libopencv_objdetect.so.4.10.0
opencv_test: /usr/local/lib/libopencv_photo.so.4.10.0
opencv_test: /usr/local/lib/libopencv_stitching.so.4.10.0
opencv_test: /usr/local/lib/libopencv_video.so.4.10.0
opencv_test: /usr/local/lib/libopencv_videoio.so.4.10.0
opencv_test: /usr/local/lib/libopencv_imgcodecs.so.4.10.0
opencv_test: /usr/local/lib/libopencv_dnn.so.4.10.0
opencv_test: /usr/local/lib/libopencv_calib3d.so.4.10.0
opencv_test: /usr/local/lib/libopencv_features2d.so.4.10.0
opencv_test: /usr/local/lib/libopencv_flann.so.4.10.0
opencv_test: /usr/local/lib/libopencv_imgproc.so.4.10.0
opencv_test: /usr/local/lib/libopencv_core.so.4.10.0
opencv_test: CMakeFiles/opencv_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/robosub/navigation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable opencv_test"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/opencv_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/opencv_test.dir/build: opencv_test
.PHONY : CMakeFiles/opencv_test.dir/build

CMakeFiles/opencv_test.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/opencv_test.dir/cmake_clean.cmake
.PHONY : CMakeFiles/opencv_test.dir/clean

CMakeFiles/opencv_test.dir/depend:
	cd /home/robosub/navigation/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/robosub/navigation /home/robosub/navigation /home/robosub/navigation/build /home/robosub/navigation/build /home/robosub/navigation/build/CMakeFiles/opencv_test.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/opencv_test.dir/depend

