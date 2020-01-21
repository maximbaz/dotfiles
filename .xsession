#!/bin/sh

# Initial X configuration

xrandr --dpi 96                                            # Set High DPI
xcalib "$HOME/.dotfiles/dell_xps15.icm"                    # Calibrate screen
xset s off -dpms                                           # Prevent screen from turning off
xset r rate 250 45                                         # Set keyboard repeat rate
