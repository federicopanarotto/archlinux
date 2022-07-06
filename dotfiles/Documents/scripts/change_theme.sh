#!/bin/bash

sudopasswd="stocazzo"
echo $sudopasswd | sudo -S echo

wl_purple="purple_mountains"
wl_cyan="cyan_mountains"
wl_pink="pink_mountains"
wl_black="black_mountains"
wl_green="green_mountains"
wl_red="red_mountains"
wl_lightblue="lightblue_mountains"

wl_gattoz="gattot"

WLPATH="$HOME/.config/wallpaper"

clear

echo "$(tput setab 1)   _____ _    _          _   _  _____ ______   _______ _    _ ______ __  __ ______ "
echo '  / ____| |  | |   /\   | \ | |/ ____|  ____| |__   __| |  | |  ____|  \/  |  ____|'
echo ' | |    | |__| |  /  \  |  \| | |  __| |__       | |  | |__| | |__  | \  / | |__   '
echo ' | |    |  __  | / /\ \ | . ` | | |_ |  __|      | |  |  __  |  __| | |\/| |  __|  '
echo ' | |____| |  | |/ ____ \| |\  | |__| | |____     | |  | |  | | |____| |  | | |____ '
echo '  \_____|_|  |_/_/    \_\_| \_|\_____|______|    |_|  |_|  |_|______|_|  |_|______|'
echo '                                                                                   '
printf "\033[0m\n"

echo "FAST SCRIPT TO CUSTOMIZE YOUR WM"
echo ""
echo "Select a theme option:"
echo "   1. $wl_purple"
echo "   2. $wl_cyan"
echo "   3. $wl_pink"
echo "   4. $wl_black"
echo "   5. $wl_green"
echo "   6. $wl_red"
echo "   7. $wl_lightblue"
echo ""
read -p "Enter selection: " x

if [ $x == "0" ]
then
	image=$wl_orange
fi

case $x in
	1)
	image=$wl_purple
	color=violet
	;;
	2)
	image=$wl_cyan
	color=cyan
	;;
	3)
	image=$wl_pink
	color=pink
	;;
	4)
	image=$wl_black
	color=black
	;;
	5)
	image=$wl_green
	color=green
	;;
	6)
	image=$wl_red
	color=red
	;;
	7)
	image=$wl_lightblue
	color=breeze
	;;
	69)
	image=$wl_gattoz
	color=palebrown
	;;

esac

# for x in {0..2}
# do
#	for i in {30..37}
#	do
# 	 	for a in {40..47}
#		do
# 			echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
# 		done
# 		echo
# 	done
# done
# echo ""

echo ""
wal --preview

echo "Applying desktop wallpaper"
sed -i 's/wallpaper.png/$image.png/g' $HOME/.xinitrc | echo > $WLPATH/inutile.log

echo "Selecting color palette"
wal -i $WLPATH/$image.png > $WLPATH/inutile.log
cp $WLPATH/$image.png $WLPATH/wallpaper.png

echo "Changing polybar colors"
echo "Changing rofi colors"
$HOME/Documents/scripts/wal_update.sh
xrdb $HOME/.Xresources
$HOME/.config/polybar/launch.sh > $WLPATH/inutile.log

echo "Changing papirus color icons"
papirus-folders -l -C $color --theme Papirus-Dark > $WLPATH/inutile.log
sed -i 's/$image.png/wallpaper.png/g' $HOME/.xinitrc

printf "Theme set to "
echo $(tput setaf 10) $image 
printf "\033[0m\n"

source $HOME/.bashrc
