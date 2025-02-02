# Navigation Project

Navigation CrossPLA is a cross-platform navigation project written in C++ and configured with CMake. It leverages OpenCV for computer vision tasks and includes organized folders for source (src/). The goal is to develop a robust, portable navigation solution that can be built and run on multiple platforms with minimal configuration.

## installation instructions
1. Download the exact binary distribution Depending on your OS (operating system) (e.g., Windows, Mac, and more).
        Cmake (3.31.4) = https://cmake.org/download/

2. Installing Opencv, Depending on your OS once again pick the correct download.
        Opencv (OpenCV – 4.10.0) = https://opencv.org/releases/
            In my case it is Windows. click on the windows button then install to a path for me it is C:\opencv


# Setup Environment Variables

1. Create a new environment variable (Windows > Edit the system environment variables). Restart the VS Code to take effect if it is already open.
   This step is required when we call find_package(OpenCV REQUIRED) in the CMakeList.txt file as we will see later.
   
   Under (User variables) click (new...) and add
   Variable name: ```OpenCV_DIR```
   Value Value: ```C:\opencv\build```
   
   unless you installed the opencv somewhere else this should be right.

2. Add the following paths to your environment variables (Windows > Edit the system environment variables).
   This is to find the bin and lib folders.

   Under (User variables) click (path) and then click new and add the following 3 things (one by one)
   ```C:\Program Files\CMake\bin```
   ```C:\opencv\build\x64\vc16\bin```
   ```C:\opencv\build\x64\vc16\lib```

## Build Instructions

### Windows and Mac
```PowerShell
.\build_and_run.ps1
```
