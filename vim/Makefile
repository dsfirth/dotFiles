PWD=$(shell pwd)

install:
	ln -s "$(PWD)/gvimrc" ~/.gvimrc
	ln -s "$(PWD)/vimrc" ~/.vimrc
	if [ ! -d ~/.vim ]; then
		mkdir ~/.vim
	fi
	mkdir ~/.vim/bundle
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

	vim -c BundleInstall! -c BundleClean -c qa

