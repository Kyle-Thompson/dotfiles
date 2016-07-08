" Leader 
let mapleader = ',' " Set mapleader to ,

" Indentation (TODO: it seems like there's a lot of redundancy. learn more.)
set tabstop=4       " A tab is 4 spaces wide.
set softtabstop=4   " Number of spaces to replace tabs by.
set expandtab       " Use spaces instead of tabs. (Insert mode)
set shiftwidth=4    " Number of spaces for autoindent
set smarttab        " Go to next tabstop when tab pressed. (Insert mode)
set smartindent     " TODO
set autoindent      " TODO

" Searching
set ignorecase      " Ignore case when searching.
set smartcase       " Match given captials in search. (Override ignorecase)
set incsearch       " Incremental searching. (TODO: find out more)
set hlsearch        " Highlight previous searches.

" Swapfiles
set noswapfile      " 
"set nobackup       " TODO
"set nowb           " TODO

" Scrolling
set scrolloff=4     " Start scrolling 4 lines from the bottom.
set sidescrolloff=8 " TODO verify
set sidescroll=1    " TODO verify

" Folds (TODO learn)

" Completion (TODO learn more)
set wildmode=list:longest
set wildmenu
set wildignore=*.o

" Uncatagorized (TODO: for now)
set number          " Show line numbers.
set hidden          " TODO
set visualbell      " No beeps.
syntax on           " Syntax highlighting

" Plugins
call plug#begin('~/.config/nvim/plugged')

" status line
Plug 'vim-airline/vim-airline'

" tree file explorer
Plug 'scrooloose/nerdtree'

Plug 'scrooloose/nerdcommenter'   " commenting utility

Plug 'tpope/vim-fugitive'         " git wrapperi

Plug 'valloric/youcompleteme'     " code completion

Plug 'godlygeek/tabular'          " text alignment

call plug#end()
