#!/usr/bin/env zsh

# Load environment variables for GUI apps

source "$HOME/.zsh/environment.zsh"

# Initial configuration and autostart some apps

xrandr --dpi 210                                           # Set High DPI
xcalib "$HOME/.dotfiles/dell_xps15.icm"                    # Calibrate screen
hsetroot -solid "#333333"                                  # Set desktop color
compton &                                                  # Enable composition
start-pulseaudio-x11 &                                     # Pulse audio daemon
xset s off -dpms                                           # Prevent screen from turning off
xset r rate 250 45                                         # Set keyboard repeat rate
xset m 3/1 4                                               # Set mouse cursor speed

numlockx &                                                 # Turn on NumLock
unclutter &                                                # Hide mouse when using keyboard

copyq &                                                    # Clipboard manager
hotshots &                                                 # Screenshot manager
udiskie --smart-tray &                                     # Automatically mount usb drives
thunderbird &                                              # Mail
wire-desktop &                                             # Messaging
server-notify &                                            # libnotify over ssh

exec i3                                                    # WM
