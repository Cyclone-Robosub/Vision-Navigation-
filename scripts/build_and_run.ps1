param(
    [switch]$Clean,   # Enable clean build
    [switch]$Debug,   # Enable debug build
    [switch]$Release  # Enable release build
)

# Function to configure CMake
function Configure-CMake {
    param([string]$BuildType)
    Write-Host "⚙️ Configuring the project with CMake for $BuildType build..."
    cmake .. -DCMAKE_BUILD_TYPE=$BuildType
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Error: CMake configuration for $BuildType failed."
        Set-Location -Path ".."
        exit 1
    }
}

# Function to build project
function Build-Project {
    param([string]$Config)
    Write-Host "🔨 Building the project in $Config mode..."
    cmake --build . --config $Config
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Error: Build failed in $Config mode."
        Set-Location -Path ".."
        exit 1
    }
}

# Function to run executable
function Run-Executable {
    param([string]$Path)
    if (Test-Path $Path) {
        Write-Host "🚀 Running the application..."
        & $Path
    } else {
        Write-Host "❌ Error: Executable not found at $Path"
        exit 1
    }

    if (Test-Path (Split-Path $Path -Parent)) {
        Write-Host "📂 Opening the output folder..."
        Invoke-Item -Path (Split-Path $Path -Parent)
    }
}

# 🧹 Clean Option
if ($Clean) {
    Write-Host "🧹 Cleaning the build directory..."
    Remove-Item -Recurse -Force ".\build" -ErrorAction SilentlyContinue
    mkdir build | Out-Null

    Set-Location -Path ".\build"

    if ($Debug) {
        Configure-CMake -BuildType "Debug"
    } elseif ($Release) {
        Configure-CMake -BuildType "Release"
    } else {
        Write-Host "✅ Clean completed. Exiting without running the program."
        Set-Location -Path ".."
        exit 0
    }
}

# 🐞 Debug Mode
if ($Debug) {
    if (-not $Clean) { Set-Location -Path ".\build" }
    Configure-CMake -BuildType "Debug"
    Build-Project -Config "Debug"

    $debugExe = ".\Debug\opencv_test.exe"
    if (Test-Path $debugExe) {
        Run-Executable -Path $debugExe
    } else {
        Write-Host "❌ Debug executable not found at $debugExe"
        exit 1
    }

    Set-Location -Path ".."
    Write-Host "✅ Debug build and run completed."
    exit 0
}

# 🔨 Release Mode
if ($Release) {
    if (-not $Clean) { Set-Location -Path ".\build" }
    Configure-CMake -BuildType "Release"
    Build-Project -Config "Release"

    $releaseExe = ".\Release\opencv_test.exe"
    if (Test-Path $releaseExe) {
        Run-Executable -Path $releaseExe
    } else {
        Write-Host "❌ Release executable not found at $releaseExe. Checking alternative path..."
        $releaseExeAlt = ".\opencv_test.exe"
        if (Test-Path $releaseExeAlt) {
            Write-Host "✅ Found executable at alternative path: $releaseExeAlt"
            Run-Executable -Path $releaseExeAlt
        } else {
            Write-Host "❌ Error: Executable not found in expected paths."
            exit 1
        }
    }

    Set-Location -Path ".."
    Write-Host "✅ Release build and run completed."
    exit 0
}

# 🛑 Default Case
Write-Host "⚠️ No valid parameter detected. Please use one of the following:"
Write-Host "   - `.\\build_and_run.ps1 -Clean` → Clean and configure only"
Write-Host "   - `.\\build_and_run.ps1 -Clean -Debug` → Clean, configure, build, and run in Debug mode"
Write-Host "   - `.\\build_and_run.ps1 -Clean -Release` → Clean, configure, build, and run in Release mode"
exit 1
