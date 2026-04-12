###############################################################################
# MacOS defaults                                                              #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Menu bar: show battery percentage
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

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

# Disable Desktop icons and widgets
defaults write com.apple.finder CreateDesktop false
defaults write com.apple.WindowManager StandardHideWidgets -bool true

###############################################################################
# Keyboard & Input                                                            #
###############################################################################

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false


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

# Add apps to the dock
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/System/Applications/Utilities/Terminal.app"
dockutil --no-restart --add "/System/Applications/Mail.app"
dockutil --no-restart --add "~/Applications/Discord.app"
dockutil --no-restart --add "~/Applications/Steam.app"
dockutil --no-restart --add "~/Applications/Heroic.app"
dockutil --no-restart --add "~/Applications/OmniDiskSweeper.app"



###############################################################################
# Kill affected applications                                                  #
###############################################################################


for app in "Dock" "SystemUIServer" "cfprefsd" "ControlCenter";do
  killall "${app}" &> /dev/null
done
