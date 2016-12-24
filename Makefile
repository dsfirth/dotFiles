PWD=$(shell pwd)

all: update

install:
	@echo "Backing up existing .vim and .vimrc to $(HOME)/.vim[rc].bak,"
	@if [ -e $(HOME)/.vim ]; then mv $(HOME)/.vim $(HOME)/.vim.bak; fi
	@if [ -e $(HOME)/.vimrc ]; then mv $(HOME)/.vimrc $(HOME)/.vimrc.bak; fi
	@echo "initializing submodules,"
	git submodule update --init
	@echo "Linking up new .vim and .vimrc,"
	ln -s ${PWD}/vim $(HOME)/.vim
	ln -s ${PWD}/vimrc $(HOME)/.vimrc
	@echo "All done.  Happy Vimming!"

update:
	git submodule foreach git pull origin master
	@make -s pathogen

pathogen:
	curl -LSso ${PWD}/vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

clean:
	rm -fR ~/.vim ~/.vimrc
