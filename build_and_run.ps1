# Create the build directory if it doesn't already exist
if (!(Test-Path -Path ".\build")) {
    mkdir build
}

# Run cmake to configure the project
cmake -B .\build\

# Build the project
cmake --build .\build\

# Execute the resulting executable
& .\build\Debug\OpenCV_vision.exe
