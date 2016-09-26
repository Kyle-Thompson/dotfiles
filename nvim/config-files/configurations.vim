" Leader
let mapleader = ',' " Set mapleader to ,

" Indentation (TODO: it seems like there's a lot of redundancy. learn more.)
set tabstop=4       " A tab is 4 spaces wide
set softtabstop=4   " Number of spaces to replace tabs by
set shiftwidth=4    " Number of spaces for autoindent
set expandtab       " Use spaces instead of tabs (Insert mode)
set smarttab        " Go to next tabstop when tab pressed (Insert mode)
set smartindent     " TODO
set autoindent      " TODO
set copyindent      " TODO

" Searching
set ignorecase      " Ignore case when searching
set smartcase       " Match given captials in search. (Override ignorecase)
set incsearch       " Incremental searching. (TODO: find out more)
set hlsearch        " Highlight previous searches

" Word wrapping (soft)
set wrap            " Spread long lines across multiple lines
set linebreak       " Do not break words on wrap
set nolist          " Do not show characters at the end of lines (needed for linebreak)

" Swapfiles
set noswapfile      " Do not create swap files
"set nobackup       " TODO
"set nowb           " TODO

" Spliting
set splitbelow      " Vertical splits open below current window
set splitright      " Horizontal splits open right of the current window

" Scrolling
set scrolloff=4     " Start scrolling 4 lines from the bottom.
set sidescrolloff=8 " TODO verify
set sidescroll=1    " TODO verify

" Folds (TODO learn)

" Completion (TODO learn more)
set wildmode=list:longest
set wildmenu
set wildignore=*.o

" Visual
set number          " Show line numbers
set relativenumber  " Line numbers are relative to current line
set cursorline      " Highlight cursorline
syntax on           " Syntax highlighting
syntax enable       " TODO
set background=dark " Use colours that suit a dark background
set termguicolors   " Enable true colours

" Uncatagorized (TODO: for now)
set hidden          " Hide file, don't close on file switch
set visualbell      " No beeps

