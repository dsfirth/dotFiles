PWD=$(shell pwd)

install: ~/.vimrc ~/.vim ~/.vim/bundle

~/.vim:
	mkdir ~/.vim

~/.vim/bundle:
	mkdir ~/.vim/bundle

~/.vimrc:
	ln -s $(PWD)/vimrc ~/.vimrc

clean:
	rm -fR ~/.vim ~/.vimrc
