#!/bin/bash

setup_brew() {
    echo "Setting up brew"

    bash ./setup_brew.sh

    # Ensure brew is in the path for the rest of this script for Apple Silicon and Intel macs
    if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}


case "$1" in
    brew)
        setup_brew
        ;;
    *)
        echo "Running full installation"
        setup_brew
        echo "Full setup complete"
        ;;
esac