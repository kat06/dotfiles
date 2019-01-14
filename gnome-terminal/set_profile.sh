#!/bin/bash

overr () {
	echo "$1"
	fd=`echo $HOME/.local/share/fonts`
	if [ ! -e "$fd" ]; then
		mkdir -p $fd
	fi
	if [ ! -e "$fd/Cica-Regular.ttf" ]; then
		echo "copy fonts file..."
		sudo cp ./fonts/Cica-Regular.ttf "$fd"
	fi

	echo "Overriding..."
	dconf load /org/gnome/terminal/legacy/profiles:/:$1/ < ubuntu-gnome-terminal-profile-template
	if [ ! $? == 0 ]; then
		echo "Error... check script."
		exit 1
	fi
}


OLD_IFS=$IFS
IFS=$'\''


echo "You have these profile. Please choose profile-id-number that override my original profile"
a=(`gsettings get org.gnome.Terminal.ProfilesList list`)
profile_list=()
n=0

# getting profile number 
for i in ${a[@]}; do
	j="$(( n % 2 ))"
	if [ $j -eq 1 ];then
		profile_list=("${profile_list[@]}" $i)
	fi
	n=$(( n + 1 ))
done


# select overrde profile number
profile_list=("${profile_list[@]}" "exit")
select v in "${profile_list[@]}"
do
	if [ "$v" = "exit" ]; then
		echo "Bye."
		break
	elif ! expr "$v" : "[1-${#profile_list[@]}]" >& /dev/null; then
		echo "Please input number between 1 - ${#profile_list[@]}"
		break
	else
		read -p "Override(Delete) $v ok? (y/n): " yn
		case "$yn" in 
			[yY]*)	echo "Overrinding $v..."; overr $v ; exit ;;
			*) 			echo "abort."; exit ;;
		esac
	fi
done
IFS=$OLD_IFS
