" Modeline and Notes {{{
" vim: set sw=4 ts=4 sts=4 et foldmarker={{{,}}} foldlevel=1 foldmethod=marker:
"
" This is the personal .vimrc of Darren S. Firth. Much of the organizational
" structure was borrowed from spf13-vim.
" You can find me at https://github.com/dsfirth/dotfiles/vim
"
" }}}

" Environment {{{

function! WIN32()
    return (has('win16') || has('win32') || has('win64'))
endfunction

" basics
set nocompatible                " be iMproved (must be first)
set encoding=utf-8

" Windows compatibility; on Windows, use '.vim' instead of 'vimfiles' (makes synchronization across systems easier)
if WIN32()
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" }}}
" Vundle.vim {{{

" requisite setup to ensure that the ~/.vim/bundle/ system works
filetype off                    " required! (says Vundle)
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')

Plugin 'gmarik/Vundle.vim'      " let Vundle manage Vundle, required!

Plugin 'chriskempson/base16-vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'lsdr/monokai'
Plugin 'altercation/vim-colors-solarized'

Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-shell'

Plugin 'PProvost/vim-ps1'
Plugin 'tpope/vim-fugitive'

call vundle#end()               " required

" }}}
" General {{{

set background=dark             " assume a dark background
filetype plugin indent on       " automatically detect file type
syntax on                       " syntax highlighting

set history=1000                " store a ton of history (default is 20)
set hidden

set backup                      " backups are nice ...
if has('persistent_undo')
    set undofile                " so is persistent undo ...
endif

" }}}
" Vim UI {{{

silent! colorscheme jellybeans

set cmdheight=2                 " number of lines used for the command-line
set noshowmode                  " hide the default mode text (e.g. -- INSERT -- ) below the statusline

set cursorline                  " highlight current line
highlight clear CursorLineNr    " remove highlight color from current line number

if has('cmdline_info')
    set ruler                   " show the ruler
    set showcmd                 " show partial commands in the status line
endif

if has('statusline')
    set laststatus=2
endif

set backspace=indent,eol,start  " backspace for dummies
set colorcolumn=+1
set number                      " line numbers on
set incsearch                   " find-as-you-type search
set hlsearch                    " highlight search results
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion; list matches, then longest common part, then all
set scrolloff=3                 " minimum lines to keep above and below the cursor
"set list
set listchars=eol:¬,tab:\|\ ,trail:·,extends:›,precedes:‹

" }}}
" Formatting {{{

set nowrap                      " long lines do [not] wrap
set autoindent                  " indent at the same level of the previous line
set shiftwidth=4                " use indent of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indent

set textwidth=120               " break at 120 characters

autocmd FileType xml setlocal expandtab shiftwidth=2 softtabstop=2

" }}}
" Key (re)Mappings {{{

" mappings to access buffers
" \l        : list buffers
" \b \f \g  : go back/forward/last-used
nnoremap <silent> <Leader>l :ls<CR>
nnoremap <silent> <Leader>b :bp<CR>
nnoremap <silent> <Leader>f :bn<CR>
nnoremap <silent> <Leader>g :e#<CR>

" clear search highlighting
nnoremap <silent> <Leader><Leader> :nohl<CR>

" visual [in|out]dentation (does not exit Visual mode)
vnoremap > >gv
vnoremap < <gv

" adjust viewports to the same size
noremap <Leader>= <C-w>=

" }}}
" Plugins {{{

" NERDTree {{{
noremap <F4> :NERDTreeToggle<CR>
inoremap <F4> <Esc>:NERDTreeToggle<CR>

" Close all open buffers on entering a window if the only buffer that's left is the NERDTree buffer original
" source: https://github.com/scrooloose/nerdtree/issues/21
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
" vim-airline {{{
" Set configuration options for the statusline plugin, vim-airline.
let g:airline#extensions#tabline#enabled = 1

let g:airline_powerline_fonts = 1
if !exists('g:airline_powerline_fonts')
    " use basic separators when powerline fonts are not available
    let g:airline_left_sep=' '
    let g:airline_right_sep=' '
endif
" }}}

" }}}
" GUI Settings {{{

" GVIM- (here instead of .gvimrc)
if has('gui_running')
    set guioptions-=m           " remove menu bar
    set guioptions-=T           " remove Toolbar
    set guioptions-=r           " remove (always-visible) right-hand scrollbar
    set guioptions-=L           " remove left-hand scrollbar

    set columns=150             " 150 columns of text
    set lines=40                " 40 lines of text instead of 24

    if WIN32()
        set guifont=DejaVu_Sans_Mono_for_Powerline:h10:cANSI,Consolas:h11:cDEFAULT
    endif
endif

" }}}
" Functions {{{

" Initialize directories {{{
" Keep persistent vim files (.swp, etc.) off my lawn!
" original source: https://github.com/spf13/spf13-vim (modified)
function! InitializeDirectories()
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
endfunction
call InitializeDirectories()
" }}}

" }}}
