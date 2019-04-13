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
set fillchars+=vert:\| |  " use | for vertical split borders
if has('nvim')
  set fillchars+=eob:\ |  " no ~ for end-of-buffer lines.
endif

" folds

" indentation
set softtabstop=2   " number of spaces to replace tabs by
set shiftwidth=2    " number of spaces for autoindent
set expandtab       " use spaces instead of tabs

" miscelanious
set hidden          " hide file, don't close on file switch
set autoread        " automatically update buffer when file chaged externally
set pumheight=30    " limits popup menu height
set noshowmode      " don't display mode under statusline (e.g. -- INSERT --)

" safety files
set noswapfile      " do not create swap files
set nobackup        " do not create backup files

" scrolling
set scrolloff=4     " start scrolling 4 lines from the bottom

" searching
set ignorecase      " ignore case when searching
set smartcase       " match any given captials in search

" shortmess
set shortmess=cas
" set shortmess+=c    " no (match n of m) or (the only match) messages
" set shortmess+=a    " all abbreviations
" set shortmess+=s    " no (search hit BOTTOM) messages

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
