#!/bin/bash

setup_brew() {
    if ! command -v brew &> /dev/null; then 
        echo "Setting up brew"

        bash ./setup_brew.sh

        # Ensure brew is in the path for the rest of this script for Apple Silicon and Intel macs
        if [[ $(uname -m) == 'arm64' ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
}

brew_packages() {
    brew bundle --file=install/Brewfile
}

macos() {
    bash macos/defaults.sh
}

case "$1" in
    brew)
        setup_brew
        ;;
    packages)
        setup_brew
        brew_packages
        ;;
    macos)
        setup_brew
        brew_packages
        macos
        ;;
    *)
        echo "Running full installation"
        setup_brew
        brew_packages
        macos
        echo "Full setup complete"
        ;;
esac
