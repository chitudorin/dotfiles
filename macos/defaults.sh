###############################################################################
# MacOS defaults                                                              #
###############################################################################

# Set macOS appearance to automatically switch between light and dark mode
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true

###############################################################################
# Night Shift (via nightlight CLI)                                            #
###############################################################################

if command -v nightlight &> /dev/null; then
  nightlight schedule 9pm 7am
  nightlight temp 100
else
  echo "nightlight is not installed."
fi
