# Navigation Project

Navigation CrossPLA is a cross-platform navigation project written in C++ and configured with CMake. It leverages OpenCV for computer vision tasks and includes organized folders for source (src/), headers (include/), build scripts (scripts/), and platform-specific toolchains (toolchains/). The goal is to develop a robust, portable navigation solution that can be built and run on multiple platforms with minimal configuration.

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

### Macs

Run this if you have never installed the dependency, (opencv, clang, cmake, etc)
```bash
./scripts/mac_setup.sh
```
And run this any time you want to build and execute the navigation program.
```bash
./scripts/build-and_run.sh debug
```
or release:
```bash
./scripts/build-and_run.sh release
```
