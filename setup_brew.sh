#!/bin/bash

NON_ADMIN_USER=$(whoami)

if [[ $(uname -m) == 'arm64'  ]]; then
    CHOWN_CMD="sudo chown -R $NON_ADMIN_USER:staff /opt/homebrew"
    BREW_BIN="/opt/homebrew/bin/brew"
else
    CHOWN_CMD="sudo chown -R $NON_ADMIN_USER:staff /usr/local/Homebrew /usr/local/Caskroom /usr/local/Cellar /usr/local/var/Homebrew"
    BREW_BIN="/usr/local/bin/brew"
fi

ADMIN_CMD="NONINTERACTIVE=1 /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\" && $CHOWN_CMD"

read -p "Enter your admin username: " ADMIN_USER

echo "You'll be prompted to enter the admin password several times."

su "$ADMIN_USER" -c "sudo -v && $ADMIN_CMD"

if [ $? -eq 0 ]; then
    echo "Success! Run these to add brew to PATH:"
    echo "echo 'eval \"\$($BREW_BIN shellenv)\"' >> /Users/$NON_ADMIN_USER/.zprofile"
    echo "eval \"\$($BREW_BIN shellenv)\""
else
    echo "Something went wrong!"
fi
