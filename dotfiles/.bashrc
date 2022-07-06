#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# wal -i $HOME/.config/wallpaper/wallpaper.png

# Import colorscheme from "wal" asynchronously
# & 	# Run the process in the background
# ()	# Hide shell job control messages
(cat $HOME/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
cat $HOME/.cache/wal/sequences

# To add support for TTYs this line can be optionally added
source $HOME/.cache/wal/colors-tty.sh

# Start Neofetch
neofetch

# Custom commands
alias chthm='$HOME/Documents/scripts/change_theme.sh'

# PS1 Config
export "PS1=[37m[[36m\u[36m@[36m\h [37m\W[37m]\$ "

