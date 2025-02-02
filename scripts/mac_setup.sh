#!/bin/bash

# Function to check exit status
check_success() {
  if [[ $? -ne 0 ]]; then
    echo "❌ ERROR: $1 failed. Exiting..."
    exit 1
  fi
}

# Ensure Xcode Command Line Tools are installed
if xcode-select -p >/dev/null 2>&1; then
  echo "✅ Xcode Command Line Tools are installed. Skipping installation."
else
  echo "⚠️ Xcode Command Line Tools are not installed. Installing now..."
  xcode-select --install
  check_success "Xcode Command Line Tools installation"
fi

# Ensure Homebrew is installed
if command -v brew >/dev/null 2>&1; then
  echo "✅ Homebrew is installed."
else
  echo "⚠️ Homebrew is not installed. Installing now..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  check_success "Homebrew installation"

  # Ensure Homebrew is available in the PATH
  if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  # Verify that Brew was installed successfully
  if ! command -v brew >/dev/null 2>&1; then
    echo "❌ ERROR: Homebrew installation failed. Exiting..."
    exit 1
  fi
fi

# Update Homebrew before installing packages
echo "🔄 Updating Homebrew..."
brew update
check_success "Homebrew update"

# Install required packages
echo "📦 Installing project build tools and dependencies..."
PACKAGES=("ninja" "opencv" "cmake")

for pkg in "${PACKAGES[@]}"; do
  if brew list --formula | grep -q "^${pkg}$"; then
    echo "✅ $pkg is already installed. Skipping..."
  else
    brew install "$pkg"
    check_success "Installation of $pkg"
  fi
done

echo "🎉 All dependencies installed successfully!"

