# Navigation Project

Navigation CrossPLA is a cross-platform navigation project written in C++ and configured with CMake. It leverages OpenCV for computer vision tasks and includes organized folders for source (src/), headers (include/), build scripts (scripts/), and platform-specific toolchains (toolchains/). The goal is to develop a robust, portable navigation solution that can be built and run on multiple platforms with minimal configuration.

## installation instructions
1. Depending on your OS (operating system) (eg: Windows, mac, and more) download that exact binary distribution.
        Cmake (3.31.4) = [text](https://cmake.org/download/)

2. Installing Opencv, Depending on your OS once again pick the correct download.
        Opencv (OpenCV – 4.10.0) = [text](https://opencv.org/releases/)
            In my case it is windows. click on windows button then install to a path for me it is [text](C:\opencv)




## Build Instructions

### Windows
```powershell
.\scripts\build_and_run.ps1 -Clean -Debug
```
or if we want a release format we can do:
```powershell
.\scripts\build_and_run.ps1 -Clean -Release
```
Plus, any of -(Clean | Debug | Release) should work.
