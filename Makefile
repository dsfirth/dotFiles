PWD=$(shell pwd)

install: ~/.vimrc ~/.vim ~/.vim/bundle
#	vim -c PluginInstall! -c PluginClean -c qa

~/.vim:
	mkdir ~/.vim

~/.vim/bundle:
	mkdir ~/.vim/bundle

# ~/.vim/bundle/Vundle.vim:
# 	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

~/.vimrc:
	ln -s $(PWD)/vimrc ~/.vimrc

clean:
	rm -fR ~/.vim ~/.vimrc
