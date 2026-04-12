#!/bin/bash

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="$HOME/.local/runtime"

mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_STATE_HOME"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

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
    brew bundle --file=install/Brewfile || true
}

brew_casks() {
    export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
    brew bundle --file=install/Caskfile || true
}

macos() {
    bash macos/defaults.sh
}

link_dotfiles() {
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    for FILE in $(ls -A runcom); do
        if [ -f "$HOME/$FILE" ] && [ ! -h "$HOME/$FILE" ]; then
            echo "Backing up $HOME/$FILE to $HOME/${FILE}.bak"
            mv -v "$HOME/$FILE" "$HOME/${FILE}.bak"
        fi
    done   

    stow -d "$DOTFILES_DIR" -t "$HOME" runcom
    stow -d "$DOTFILES_DIR" -t "$XDG_CONFIG_HOME" config
}

case "$1" in
    link)
        setup_brew
        brew_packages
        link_dotfiles
        ;;
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
    casks)
        setup_brew
        brew_casks
        ;;
    *)
        echo "Running full installation"
        setup_brew
        brew_packages
        macos
        brew_casks
        link_dotfiles
        echo "Full setup complete"
        ;;
esac
