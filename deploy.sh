#!/bin/bash


DOT_DIR="${HOME}/dotfiles"
DOT_HTTP="https://github.com/kat06/dotfiles.git"


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
  echo "Done synbolic link: ${HOME}/${f} >> ${DOT_DIR/${f}"
done

echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
