#!/bin/bash

NON_ADMIN_USER=$(whoami)
CHOWN_CMD="sudo chown -R $NON_ADMIN_USER:staff /opt/homebrew"
BREW_BIN="/opt/homebrew/bin/brew"
ADMIN_CMD="NONINTERACTIVE=1 /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\" && $CHOWN_CMD"

read -p "Enter your admin username: " ADMIN_USER

echo "You'll be prompted to enter the admin password several times."

su "$ADMIN_USER" -c "sudo -v && $ADMIN_CMD"

