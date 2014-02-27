" Modeline and Notes {{{
" vim: set foldlevel=0 foldmethod=marker:
"
" You can find me at https://github.com/dsfirth/dotfiles
" }}}

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible			" be iMproved
filetype off				" required! (says Vundle)

" On Windows, always use '.vim' instead of 'vimfiles'; this makes synchronization across (heterogeneous) systems easier.
if has("win32") || has("win64")
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Bundles (plugins) {{{
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" let Vundle manage Vundle, required!
Bundle 'gmarik/vundle'

" General
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1
if has("gui_running")
	if has("gui_win32")
		let g:airline#extensions#whitespace#symbol = '•'
		let g:airline_powerline_fonts = 1
	endif
endif
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-shell'

" General Programming
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'PProvost/vim-ps1'
" }}}

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set encoding=utf-8			" character encoding used in Vim: "utf-8" is required for vim-powerline

" 2 moving around, searching and patterns {{{
set incsearch				" show match for partly typed search command
" }}}
" 4 displaying text {{{
set scrolloff=1				" number of screen lines to show around the cursor
set nowrap					" long lines do [not] wrap
set cmdheight=2				" number of lines used for the command-line
set listchars=eol:¬,tab:\|\ ,trail:·,extends:›,precedes:‹	" list of strings used for list mode
set number					" show the line number for each line
" }}}
" 5 syntax, highlighting and spelling {{{
set background=dark
filetype plugin indent on	" automatically detect filetype - required (by Vundle)!
syntax on					" syntax highlighting
set hlsearch				" highlight all matches for the last used search pattern
" }}}
" 6 multiple window {{{
set laststatus=2			" when to use a status line (2: always)
set hidden					" don't unload a buffer when no longer shown in a window
" }}}
" 12 messages and info {{{
set ruler					" show cursor position below each window
set showcmd					" show (partial) command keys in the status line
set noshowmode				" hide the default mode text (e.g. -- INSERT -- ) below the statusline
" }}}
" 15 tabs and indenting {{{
set tabstop=4				" number of spaces a <Tab> in the text stands for
set shiftwidth=4			" number of spaces used for each step of (auto)indent
set softtabstop=4			" if non-zero, number of spaces to insert for a <Tab>
set autoindent				" automatically set the indent of a new line
"}}}
" 14 editing text {{{
set textwidth=130			" line length above which to break a line
" }}}
" 21 command line editing {{{
set history=50				" keep 50 lines of command line history
set wildmode=list:longest	" specifies <Tab> completion; list matches, then longest common part
set wildmenu				" command-line completion shows a list of matches
" }}}

" Key (re-)Mappings {{{
" Set leader to ,
" NOTE : This line MUST come before any <Leader> mappings
let mapleader = ','			" default is '\', but many prefer ',' as it's in a standard location.

" make it so ';' works like ':' for commands; saves typing and eliminates
nnoremap ; :

" visual [in|out]dentation (does not exit Visual mode)
vmap > >gv
vmap < <gv

" clear highlighted search results
nnoremap <silent> <Leader><Leader> :nohl<CR>

" adjust viewports to the same size
map <Leader>= <C-w>=
" }}}

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

" nerdtree.vim (configure NERDTree plugin) {{{

" toggle NERD tree for this tab using <F4> keyboard shortcut
imap <F4> <Esc>:NERDTreeToggle<CR>
map <F4> :NERDTreeToggle<CR>

" Close all open buffers on entering a window if the only buffer that's left is the NERDTree buffer
" original source: https://github.com/scrooloose/nerdtree/issues/21
function! s:CloseIfNERDTreeIsOnlyWindow()
	if exists("t:NERDTreeBufName")
		let nr = bufwinnr(t:NERDTreeBufName)
		if nr != -1
			if winnr("$") == 1
				q
			endif
		endif
	endif
endfunction
autocmd WinEnter * call s:CloseIfNERDTreeIsOnlyWindow()

" }}}

" Functions {{{
" Keep persistent vim files (.swp, etc.) off my lawn!
" original source: https://github.com/spf13/spf13-vim (modified)
function! InitializeDirectories() "{{{
	let parent = $HOME . '/.vim'
	let dir_list = {
	            \ 'backup': 'backupdir',
	            \ 'views': 'viewdir',
	            \ 'swap': 'directory' }

	if has('persistent_undo')
		let dir_list['undo'] = 'undodir'
	endif

	for [dirname, settingname] in items(dir_list)
		let directory = parent . '/' . dirname . "/"
		if exists("*mkdir")
			if !isdirectory(directory)
				call mkdir(directory)
			endif
		endif
		if !isdirectory(directory)
			echo "Warning: Unable to create backup directory: " . directory
			echo "Try: mkdir -p " . directory
		else
			let directory = substitute(directory, " ", "\\\\ ", "g")
			exec "set " . settingname . "=" . directory
		endif
	endfor
endfunction "}}}
call InitializeDirectories()
" }}}
