PWD=$(shell pwd)

install:
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	if [ ! -d ~/.vim ]; then
		mkdir ~/.vim
	fi
	mkdir ~/.vim/bundle
	git clone https://github.com/gmarik/Vundle.git ~/.vim/bundle/Vundle.vim

	vim -c BundleInstall! -c BundleClean -c qa

