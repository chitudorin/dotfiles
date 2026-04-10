###############################################################################
# MacOS defaults                                                              #
###############################################################################

# Set macOS appearance to automatically switch between light and dark mode
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true

# Disable mouse acceleration
defaults write NSGlobalDomain com.apple.mouse.linear -bool "true"
defaults write -g com.apple.mouse.scaling -float 6.0

###############################################################################
# Night Shift (via nightlight CLI)                                            #
###############################################################################

if command -v nightlight &> /dev/null; then
  nightlight schedule 9pm 7am
  nightlight temp 100
else
  echo "nightlight is not installed."
fi
