#!/bin/sh

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

os=$(uname -s)

echo "Detected operating system: $os"

case "$os" in
  Darwin)
    echo "Installing tools for MacOS..."
    if command_exists brew; then
      brew update
      brew install podman openssh jq yq go-task/tap/task
    else
      echo "Homebrew not found. Please install Homebrew first."
      echo "You can install it by running: /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
      exit 1
    fi
    echo "Tools installed successfully on MacOS."
    ;;
  Linux)
    if grep -q "Alpine" /etc/os-release; then
      echo "Installing tools for Alpine Linux..."
      if command_exists apk; then
        sudo apk update
        sudo apk add podman openssh-client jq yq go-task
      else
        echo "apk not found. This script is designed for Alpine-based systems."
        exit 1
      fi
      echo "Tools installed successfully on Alpine Linux."
    else
      echo "Installing tools for Debian Linux..."
      if command_exists apt-get; then
        sudo apt-get update
        sudo apt-get install -y podman openssh-client jq yq
        if ! command_exists task; then
          sudo sh -c "sh -c 'wget -q -O - https://taskfile.dev/install.sh' -- -d -b /usr/local/bin"
        fi
      else
        echo "apt-get not found. This script is designed for Debian-based systems."
        exit 1
      fi
      echo "Tools installed successfully on Debian Linux."
    fi
    ;;
  *)
    echo "Unsupported operating system: $os"
    exit 1
    ;;
esac

echo "Installation complete."
