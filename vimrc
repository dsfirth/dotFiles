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
set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin('~/vimfiles/bundle')

Plugin 'gmarik/Vundle.vim'

" General {{{
    Plugin 'chriskempson/base16-vim'
    Plugin 'kien/ctrlp.vim'
    Plugin 'nanotech/jellybeans.vim'
    Plugin 'itchyny/landscape.vim'
    Plugin 'itchyny/lightline.vim'
    Plugin 'lsdr/monokai'
    Plugin 'scrooloose/nerdtree'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-surround'
" }}}

" Javascript {{{
    Plugin 'elzr/vim-json'
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

    silent! colorscheme landscape   " load a colorscheme

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
    set listchars=eol:�,tab:\|\ ,trail:�,extends:�,precedes:�

" }}}

" Formatting {{{

    set nowrap                      " do not wrap long lines

    autocmd FileType xml setlocal expandtab shiftwidth=2 softtabstop=2

" }}}

" Key (re)Mappings {{{

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv
    
" }}}

" Plug-ins {{{

    " ctrlp.vim {{{
    " }}}

    " lightline.vim {{{
        let g:lightline = {
                    \ 'colorscheme': 'landscape',
                    \ 'active': {
                    \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], [ 'ctrlpmark' ] ]
                    \ },
                    \ 'component_function': {
                    \   'filename': 'MyFilename',
                    \   'mode': 'MyMode',
                    \   'ctrlpmark': 'CtrlPMark',
                    \ },
                    \ }

        function! MyModified()
            return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
        endfunction

        function! MyReadonly()
            return &ft !~ 'help' && &readonly ? 'RO' : ''
        endfunction

        function! MyFilename()
            let fname = expand('%:t')
            return fname == 'ControlP' ? g:lightline.ctrlp_item :
                        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                        \ ('' != fname ? fname : '[No Name]') .
                        \ ('' != MyModified() ? ' ' . MyModified() : '')
        endfunction

        function! MyMode()
            let fname = expand('%:t')
            return fname == 'ControlP' ? 'CtrlP' :
                        \ winwidth(0) > 60 ? lightline#mode() : ''
        endfunction

        function! CtrlPMark()
            if expand('%:t') =~ 'ControlP'
                call lightline#link('iR'[g:lightline.ctrlp_regex])
                return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item, g:lightline.ctrlp_next], 0)
            else
                return ''
            endif
        endfunction

        let g:ctrlp_status_func = {
                    \ 'main': 'CtrlPStatusFunc_1',
                    \ 'prog': 'CtrlPStatusFunc_2',
                    \ }

        function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
            let g:lightline.ctrlp_regex = a:regex
            let g:lightline.ctrlp_prev = a:prev
            let g:lightline.ctrlp_item = a:item
            let g:lightline.ctrlp_next = a:next
            return lightline#statusline(0)
        endfunction

        function! CtrlPStatusFunc_2(str)
            return lightline#statusline(0)
        endfunction

        " add on-the-fly colorscheme updates to lightline
        augroup LightLineColorscheme
            autocmd!
            autocmd ColorScheme * call s:lightline_update()
        augroup END
        function! s:lightline_update()
            if !exists('g:loaded_lightline')
                return
            endif
            try
                if g:colors_name =~# 'wombat\|solarized\|landscape\|jellybeans\|Tomorrow'

                    let g:lightline.colorscheme = 
                                \ substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '') .
                                \ (g:colors_name ==# 'solarized' ? '_' . &background : '')
                    call lightline#init()
                    call lightline#colorscheme()
                    call lightline#update()
                endif
            catch
            endtry
        endfunction
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
    let parent = $HOME . '/vimfiles'
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
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=1 foldmethod=marker:
" }}}
