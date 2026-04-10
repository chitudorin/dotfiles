###############################################################################
# Night Shift (via nightlight CLI)                                            #
###############################################################################

if command -v nightlight &> /dev/null; then
  nightlight schedule 9pm 7am
  nightlight temp 100
else
  echo "nightlight is not installed."
fi
