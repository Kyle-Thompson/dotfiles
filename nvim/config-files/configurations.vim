" ==============================================================================
" ==================   General   ===============================================
" ==============================================================================

" leader
let mapleader = ' '

" clipboard
set clipboard=unnamedplus  " enable system clipboard

" completion
set wildmode=list:longest

" fill chars
set fillchars+=vert:\|
if has('nvim')
  set fillchars+=eob:\ 
endif

" folds

" indentation
set softtabstop=2   " number of spaces to replace tabs by
set shiftwidth=2    " number of spaces for autoindent
set expandtab       " use spaces instead of tabs

" miscelanious
set hidden          " hide file, don't close on file switch

" safety files
set noswapfile      " do not create swap files
set nobackup        " do not create backup files

" scrolling
set scrolloff=4     " start scrolling 4 lines from the bottom

" searching
set ignorecase      " ignore case when searching
set smartcase       " match any given captials in search

" spliting
set splitbelow      " vertical splits open below current window
set splitright      " horizontal splits open right of the current window

" tags
set tags=./tags;/   " recurse up directories looking for tag files.

" wildignore
set wildignore=*.o,*.pyc

" word wrapping
set wrap            " spread long lines across multiple lines
set linebreak       " do not break words on wrap
set nolist          " do not show characters at the end of lines
