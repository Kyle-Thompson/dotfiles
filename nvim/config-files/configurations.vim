" Leader
let mapleader = ',' " Set mapleader to ,

" Indentation (TODO: it seems like there's a lot of redundancy. learn more.)
set tabstop=4       " A tab is 4 spaces wide
set softtabstop=4   " Number of spaces to replace tabs by
set expandtab       " Use spaces instead of tabs (Insert mode)
set shiftwidth=4    " Number of spaces for autoindent
set smarttab        " Go to next tabstop when tab pressed (Insert mode)
set smartindent     " TODO
set autoindent      " TODO
set copyindent      " TODO

" Searching
set ignorecase      " Ignore case when searching
set smartcase       " Match given captials in search. (Override ignorecase)
set incsearch       " Incremental searching. (TODO: find out more)
set hlsearch        " Highlight previous searches

" Swapfiles
set noswapfile      " Do not create swap files
"set nobackup       " TODO
"set nowb           " TODO

" Spliting
set splitbelow      " <vertical?> splits open below current window
set splitright      " <horizontal?> splits open right of the current window
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
set cursorline      " Highlight cursorline
syntax on           " Syntax highlighting
syntax enable       " TODO
set background=dark " TODO
set termguicolors   " Enable true colours

" Uncatagorized (TODO: for now)
set hidden          " Hide file, don't close on file switch
set visualbell      " No beeps

