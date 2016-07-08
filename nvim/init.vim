" Leader
let mapleader = ','

" Indentation (TODO: it seems like there's a lot of redundancy. find out more.)
set tabstop=4      " A tab is 4 spaces wide.
set softtabstop=4  " Number of spaces to replace tabs by.
set expandtab      " Use spaces instead of tabs. (Insert mode)
set shiftwidth=4   " Number of spaces for autoindent
set smarttab       " Go to next tabstop when tab pressed. (Insert mode)
set smartindent    " TODO
set autoindent     " TODO

" Searching
set ignorecase     " Ignore case when searching.
set smartcase      " Match given captials in search. (Override ignorecase)
set incsearch      " Incremental searching. (TODO: find out more)
set hlsearch       " Highlight previous searches.

" Uncatagorized (TODO: for now)
set number         " Show line numbers.

" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'

call plug#end()
