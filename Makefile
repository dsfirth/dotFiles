PWD=$(shell pwd)

install: ~/.vimrc ~/.vim ~/.vim/autoload ~/.vim/bundle pathogen bundles

~/.vim:
        mkdir ~/.vim

~/.vim/autoload:
        mkdir ~/.vim/autoload

~/.vim/bundle:
        mkdir ~/.vim/bundle

~/.vimrc:
        ln -s $(PWD)/vimrc ~/.vimrc

bundles:
        git clone https://github.com/elzr/vim-json.git ~/.vim/vim-json
        git clone https://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible
        git clone https://github.com/tpope/vim-surround.git ~/.vim/bundle/vim-surround

pathogen:
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

clean:
        rm -fR ~/.vim ~/.vimrc
