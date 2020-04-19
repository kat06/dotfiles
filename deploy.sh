#!/bin/bash


DOT_DIR="${HOME}/dotfiles"
DOT_HTTP="https://github.com/o621/dotfiles.git"


if [ ! -d ${DOT_DIR} ] ; then
	echo "Downloadind dotfiles..."
	mkdir ${DOT_DIR}

	if type "git" > /dev/null 2>&1; then
		echo "git command doing..."
		git clone --recursive "${DOT_HTTP}" "${DOT_DIR}"
	else
		curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_HTTP}
    	tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIR}
    	rm -f ${HOME}/dotfiles.tar.gz
  	fi

  	echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
fi


cd ${DOT_DIR}

for f in .??*
do
  # ignore . files
  [[ ${f} = ".git" ]] && continue
  [[ ${f} = ".gitignore" ]] && continue
  ln -snfv ${DOT_DIR}/${f} ${HOME}/${f}
  
done

echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)

echo "bat install..."
cd ~
curl -LJO https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb
sudo dpkg -i bat_0.11.0_amd64.deb

echo $(tput setaf 2)bat install complete!. ✔︎$(tput sgr0)

echo "exa install..."
sudo apt install cargo
cargo install exa
echo $(tput setaf 2)exa install complete!. ✔︎$(tput sgr0)

echo "fish-shell install..."
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish
fisher add oh-my-fish/theme-eden
echo "exec fish" >> ~/.bash_profile
echo $(tput setaf 2)fish install complete!. ✔︎$(tput sgr0)