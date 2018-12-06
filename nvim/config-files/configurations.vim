" ========== General ==========
" =============================

" leader
let mapleader = ',' " Set mapleader to ,

" clipboard
set clipboard=unnamedplus  " Enable system clipboard

" completion
set wildmode=list:longest

" fill chars
set fillchars+=vert:\|
if has('nvim')
  set fillchars+=eob:\ 
endif

" folds

" indentation
set tabstop=2       " A tab is 2 spaces wide
set softtabstop=2   " Number of spaces to replace tabs by
set shiftwidth=2    " Number of spaces for autoindent
set expandtab       " Use spaces instead of tabs

" miscelanious
set hidden          " Hide file, don't close on file switch

" safety files
set noswapfile      " Do not create swap files
set nobackup        " Do not create backup files

" scrolling
set scrolloff=4     " Start scrolling 4 lines from the bottom

" searching
set ignorecase      " Ignore case when searching
set smartcase       " Match any given captials in search

" spliting
set splitbelow      " Vertical splits open below current window
set splitright      " Horizontal splits open right of the current window

" tags
set tags=./tags;/   " recurse up directories looking for tag files.

" visual
" set number          " Show line numbers
" set relativenumber  " Line numbers are relative to current line
if has('nvim')
  " set termguicolors   " Enable true colours
endif

" wildignore
set wildignore=*.o,*.pyc

" word wrapping
set wrap            " Spread long lines across multiple lines
set linebreak       " Do not break words on wrap
set nolist          " Do not show characters at the end of lines
