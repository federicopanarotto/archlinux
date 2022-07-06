#!/bin/bash
# "Creating new color palette vars"

WALPATH="$HOME/.cache/wal/colors"
COLORPATH="$HOME/Documents/scripts/colors.sh"
XPATH="$HOME/.Xresources"
ROFIPATH="$HOME/.local/share/rofi/themes/rounded-gray-dark.rasi"

touch $HOME/Documents/scripts/colors.sh
echo '#!/bin/bash' > $COLORPATH 

for i in {0..15}
do
	echo "*color$i:	" >> $COLORPATH
done

for i in {1..16}
do	
	tmp=$(awk "NR==$i" $WALPATH)
	if [ $i != 0 ]
	then
		let "i++"
		if [ $i == 2  ]
		then
			first=#cd
			first+="${tmp:1}"
			sed -i "${i}s/$/$first/" $COLORPATH
		else
			sed -i "${i}s/$/$tmp/" $COLORPATH
		fi
		let "i--"
	fi
done

echo "! ## Enable a color supporting Xterm ##" > $XPATH
echo "XTerm.termName: xterm-256color" >> $XPATH
echo "XTerm*faceName: Hermit" >> $XPATH

for i in {0..16}
do
	let "i++"
	if [ $i != 1 ]
	then
		tmp=$(awk "NR==$i" $COLORPATH)
		echo $tmp >> $XPATH
	fi
done

echo "* {" > $ROFIPATH

for i in {0..15}
do
	tmp=$(awk "NR==$i" $WALPATH)
	if [ $i == 1 ]
	then
		echo "fg3: #6a6a6a;" >> $ROFIPATH
		echo "fg1: #ffffff;" >> $ROFIPATH
		echo "bg1: #00000000;" >> $ROFIPATH
		echo "bg0: ${tmp}ad;" >> $ROFIPATH
	elif [ $i == 2 ]
	then
		echo "bg3: ${tmp}f2;" >> $ROFIPATH
		echo "fg2: ${tmp};" >> $ROFIPATH
	elif [ $i == 3 ]
	then
		echo "bg2: ${tmp}80;" >> $ROFIPATH
	elif [ $i == 8 ]
	then
		echo "fg0: $tmp;" >> $ROFIPATH
	fi
done

echo "}" >> $ROFIPATH
echo "@import \"rounded-common.rasi\"" >> $ROFIPATH
		

		
	



