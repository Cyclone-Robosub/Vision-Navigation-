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

# Alternative: Set up for WSL

## Windows (10/11)

1. Enable Wsl for Windows.
    1. Enable the wsl feature.
        1. Look up in the windows search bar “turn windows features on or off”. Open the panel.
        2. Find the “Windows Subsystem for Linux” feature and tick the checkbox to enable it.
        3. Restart your machine. Make sure that you have all important work saved before restarting.
    2. Install Ubuntu
        1. search up “Ubuntu” in the Microsoft Store.
        2. Click on “Get” button.
        3. After installation finishes, open the Windows terminal.
        4. On the list of tabs, there should be a dropdown button that looks like the letter (V). Click on it and select Ubuntu.
        5. Follow the instructions if prompted
    3. Install the needed packages
        1. Run the following commands
        
        ```bash
        sudo apt update && sudo apt upgrade
        sudo apt install -y build-essential ninja-build cmake libopencv-dev
        ```
        
    4. If you do not have vscode, install vscode. Packages are found ([here](https://code.visualstudio.com/Download)).
    5. Open up vscode.
    6. (Optional) Set up a profile for C/C++ development specifically. ([link](https://code.visualstudio.com/docs/editor/profiles))
    7. Follow the instructions [here](https://code.visualstudio.com/docs/remote/wsl) until you have Ubuntu open in vscode. You will do this everytime you open up vscode.
    8. Download the C/C++ extension, CMake Tools extension.
    9. When the project is open, pick gcc as compiler if prompted.

## Build Instructions

### Windows and Mac
```PowerShell
.\build_and_run.ps1
```

