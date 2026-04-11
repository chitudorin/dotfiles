###############################################################################
# MacOS defaults                                                              #
###############################################################################

# Set macOS appearance to automatically switch between light and dark mode
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true

# Disable mouse acceleration
defaults write NSGlobalDomain com.apple.mouse.linear -bool "true"
defaults write -g com.apple.mouse.scaling -float 6.0

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Don't show recent applications in the Dock
defaults write com.apple.dock show-recents -bool false

# Enable magnification
defaults write com.apple.dock magnification -bool true

# Set magnification size
defaults write com.apple.dock largesize -int 100
###############################################################################
# Night Shift (via nightlight CLI)                                            #
###############################################################################

if command -v nightlight &> /dev/null; then
  nightlight schedule 9pm 7am
  nightlight temp 100
else
  echo "nightlight is not installed."
fi


###############################################################################
# dockutil                                                                    #
###############################################################################

# Remove everything from the Dock
dockutil --remove all --no-restart

killall Dock

