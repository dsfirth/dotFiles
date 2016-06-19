" Environment {{{

    " Identify platform {{{
        silent function! WINDOWS()
            return (has('win16') || has('win32') || has('win64'))
        endfunction
    " }}}

    " Basics {{{
        set nocompatible                " must be first line
    " }}}

" }}}

" let Vundle manage Vundle, required
filetype off                    " required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')

Plugin 'gmarik/Vundle.vim'

" General {{{
    Plugin 'kien/ctrlp.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-surround'
" }}}

" Colorschemes {{{
    Plugin 'chriskempson/base16-vim'
    Plugin 'nanotech/jellybeans.vim'
    Plugin 'itchyny/landscape.vim'
    Plugin 'Pychimp/vim-luna'
    Plugin 'lsdr/monokai'
    Plugin 'Pychimp/vim-sol'
    Plugin 'altercation/vim-colors-solarized'
" }}}

" Javascript {{{
    Plugin 'elzr/vim-json'
" }}}

" PowerShell {{{
    Plugin 'PProvost/vim-ps1'
" }}}

call vundle#end()		            " required

" General {{{

    set background=dark
    filetype plugin indent on       " automatically detect file types
    syntax on                       " syntax highlighting

    set history=1000
    set hidden

    set backup                      " backups are nice ...
    if has('persistent_undo')
        set undofile                " so is persistent undo ...
        set undolevels=1000         " maximum number of changes that can be undone
        set undoreload=10000        " maximum number lines to save for undo on a buffer reload
    endif

" }}}

" Vim UI {{{

    silent! colorscheme jellybeans  " load a colorscheme

    set cmdheight=2
    set cursorline                  " highlight current line
    highlight clear CursorLineNr    " remove highlight color from current line number
    set noshowmode                  " hide the default mode text (e.g. -- INSERT --) below the statusline

    if has('statusline')
        set laststatus=2
    endif

    set backspace=indent,eol,start  " backspace for dummies
    set linespace=0
    set number                      " line numbers on
    set incsearch
    set hlsearch
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion: list matches, then longest common part, then all
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set sidescroll=1
    set listchars=eol:¬,tab:»\ ,trail:·,extends:>,precedes:<

" }}}

" Formatting {{{

    set nowrap                      " do not wrap long lines

    autocmd FileType xml setlocal expandtab shiftwidth=2 softtabstop=2

    autocmd BufRead,BufNewFile *.script set filetype=scope
    autocmd BufRead,BufNewFile *.module set filetype=scope
    autocmd BufRead,BufNewFile *.view set filetype=scope
" }}}

" Key (re)Mappings {{{

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " disable arrow keys
    map <up> <nop>
    map <down> <nop>
    map <left> <nop>
    map <right> <nop>
    imap <up> <nop>
    imap <down> <nop>
    imap <left> <nop>
    imap <right> <nop>

" }}}

" Plug-ins {{{

    " ctrlp.vim {{{
    " }}}

    " NERDTree {{{
        noremap <F4> :NERDTreeToggle<CR>
        inoremap <F4> <Esc>:NERDTreeToggle<CR>

        autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

        " Close all open buffers on entering a window if the only
        " buffer that's left is the NERDTree buffer
        function! s:CloseIfOnlyNerdTreeLeft()
            if exists("t:NERDTreeBufName")
                if bufwinnr(t:NERDTreeBufName) != -1
                    if winnr("$") == 1
                        quit
                    endif
                endif
            endif
        endfunction
    " }}}

    " vim-airline {{{
        let g:airline_left_sep = ''
        let g:airline_right_sep = ''
        let g:airline#extensions#tabline#enabled = 1
    " }}}
" }}}

" GUI Settings {{{

    " GVIM- (here instead of .gvimrc)
        if has('gui_running')
            set guioptions-=m   " remove menu bar
            set guioptions-=T   " remove toolbar
            set guioptions-=r   " remove (always-visible) right-hand scrollbar
            set guioptions-=L   " remove left-hand scrollbar

            set columns=150
            set lines=40

            if WINDOWS()
                set guifont=Consolas:h11:cDEFAULT
            endif
        else
            set t_Co=256
        endif
    " }}}

" Functions {{{

" Initialize directories {{{
" original source: https://github.com/spf13/spf13-vim/blob/3.0/.vimrc
function! InitializeDirectories()
    let parent = $HOME . '/.vim'
    let prefix = ''
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    let common_dir = parent . '/' . prefix

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
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

" Modeline and Notes {{{
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=2 foldmethod=marker:
" }}}
