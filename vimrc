" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:
"
" You can find me at https://github.com/dsfirth/dotfiles 
" }

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible			" be iMproved
filetype off				" required! (says Vundle)

" On Windows, always use '.vim' instead of 'vimfiles'; this makes synchronization across (heterogeneous) systems easier.
if has('win32') || has('win64')
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" let Vundle manage Vundle, required!
Bundle 'gmarik/vundle'

" Bundles (plugins) {
	" General
	Bundle 'altercation/vim-colors-solarized'
	Bundle 'xolox/vim-shell'
	Bundle 'Lokaltog/vim-powerline'

	" General Programming
	Bundle 'tpope/vim-fugitive'
" }

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

colorscheme solarized		" load a colorscheme
set encoding=utf-8			" character encoding used in Vim: "utf-8" is required for vim-powerline

" 2 moving around, searching and patterns {
set incsearch				" show match for partly typed search command
" }
" 4 displaying text {
set scrolloff=1				" number of screen lines to show around the cursor
set cmdheight=2				" number of lines used for the command-line
set listchars=eol:¬,tab:»\ ,trail:·,extends:›,precedes:‹	" list of strings used for list mode
set number					" show the line number for each line
" }
" 5 syntax, highlighting and spelling {
set background=dark
filetype plugin indent on	" automatically detect filetype - required (by Vundle)!
syntax on					" syntax highlighting
set hlsearch				" highlight all matches for the last used search pattern
" }
" 6 multiple window {
set laststatus=2			" when to use a status line (2: always)
set hidden					" don't unload a buffer when no longer shown in a window
" }
" 12 messages and info {
set showcmd					" show (partial) command keys in the status line
set ruler					" show cursor position below each window
" }
" 15 tabs and indenting {
set tabstop=4				" number of spaces a <Tab> in the text stands for
set shiftwidth=4			" number of spaces used for each step of (auto)indent
set softtabstop=4			" if non-zero, number of spaces to insert for a <Tab>
set autoindent				" automatically set the indent of a new line

" }
" 14 editing text {
set textwidth=110			" line length above which to break a line
" }
" 21 command line editing {
set history=50				" keep 50 lines of command line history
set wildmode=list:longest	" specifies <Tab> completion; list matches, then longest common part
set wildmenu				" command-line completion shows a list of matches
" }

" Key (re-)Mappings {
" Set leader to ,
" NOTE: This line MUST come before any <Leader> mappings
let mapleader = ','			" default is '\', but many prefer ',' as it's in a standard location.

" make it so ';' works like ':' for commands; saves typing and eliminates
nnoremap ; :

" visual [in|out]dentation (does not exit Visual mode)
vmap > >gv
vmap < <gv

" clear highlighted search results
nmap <silent> <Esc> :nohl<CR>

" adjust viewports to the same size
map <Leader>= <C-w>=
" }

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

" Functions {

function! InitDirectory()
	let directory = '/tmp'
	if has('win32') || has('win64')
		let directory = $TEMP
	endif
	exec "set directory=" . directory
endfunction
call InitDirectory()

" :}
