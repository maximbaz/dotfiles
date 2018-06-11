# Load environment variables for GUI apps

source "$HOME/.zsh/environment.zsh"

# Initial X configuration

xrandr --dpi 210                                           # Set High DPI
xcalib "$HOME/.dotfiles/dell_xps15.icm"                    # Calibrate screen
xset s off -dpms                                           # Prevent screen from turning off
xset r rate 250 45                                         # Set keyboard repeat rate
