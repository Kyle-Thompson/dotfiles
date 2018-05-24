" ========== General ==========
" =============================

" Leader
let mapleader = ',' " Set mapleader to ,

" Completion
set wildmode=list:longest
set wildignore=*.o,*.pyc

" Folds

" Indentation
set tabstop=2       " A tab is 2 spaces wide
set softtabstop=2   " Number of spaces to replace tabs by
set shiftwidth=2    " Number of spaces for autoindent
set expandtab       " Use spaces instead of tabs

" Miscelanious
set hidden          " Hide file, don't close on file switch

" Safety files
set noswapfile      " Do not create swap files
set nobackup        " Do not create backup files

" Scrolling
set scrolloff=4     " Start scrolling 4 lines from the bottom

" Searching
set ignorecase      " Ignore case when searching
set smartcase       " Match any given captials in search

" Spliting
set splitbelow      " Vertical splits open below current window
set splitright      " Horizontal splits open right of the current window

" Visual
" set number          " Show line numbers
" set relativenumber  " Line numbers are relative to current line
set termguicolors   " Enable true colours

" Word wrapping
set wrap            " Spread long lines across multiple lines
set linebreak       " Do not break words on wrap
set nolist          " Do not show characters at the end of lines

" Automatically change the working path to the path of the current file
autocmd BufNewFile,BufEnter * silent! lcd %:p:h
