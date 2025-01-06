param(
    [switch]$Clean,
    [switch]$Debug,
    [switch]$Release,
    [switch]$CrossCompile
)

# Configure CMake
function Configure-CMake {
    param([string]$BuildType)
    Write-Host "⚙️ Configuring CMake for $BuildType build..."
    if ($CrossCompile) {
        cmake .. -DCMAKE_TOOLCHAIN_FILE=../toolchains/toolchain-raspi.cmake -DCMAKE_BUILD_TYPE=$BuildType
    } else {
        cmake .. -DCMAKE_BUILD_TYPE=$BuildType
    }
}

# Build Project
function Build-Project {
    param([string]$Config)
    Write-Host "🔨 Building project in $Config mode..."
    cmake --build . --config $Config
}

# Run Executable
function Run-Executable {
    param([string]$Path)
    if (Test-Path $Path) {
        Write-Host "🚀 Running executable..."
        & $Path
    } else {
        Write-Host "❌ Executable not found at $Path"
    }
}

# Clean
if ($Clean) {
    Remove-Item -Recurse -Force ".\build" -ErrorAction SilentlyContinue
    mkdir build | Out-Null
    Set-Location build
    Configure-CMake -BuildType "Release"
    exit
}

# Debug
if ($Debug) {
    Set-Location build
    Configure-CMake -BuildType "Debug"
    Build-Project -Config "Debug"
    Run-Executable -Path ".\Debug\opencv_test.exe"
    exit
}

# Release
if ($Release) {
    Set-Location build
    Configure-CMake -BuildType "Release"
    Build-Project -Config "Release"
    Run-Executable -Path ".\Release\opencv_test.exe"
    exit
}

# Cross-Compile
if ($CrossCompile) {
    Set-Location build
    Configure-CMake -BuildType "Release"
    Build-Project -Config "Release"
    Write-Host "✅ Cross-compilation complete. Transfer the binary to Raspberry Pi."
    exit
}

Write-Host "⚠️ Use -Clean, -Debug, -Release, or -CrossCompile"
exit 1

