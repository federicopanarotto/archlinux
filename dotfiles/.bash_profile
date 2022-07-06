#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# StartX Automatically
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]
then
	. startx
	logout
fi

