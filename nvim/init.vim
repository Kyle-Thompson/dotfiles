""" General Configurations

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

" Safety files
set noswapfile      " Do not create swap files
set nobackup        " Do not create backup files

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



""" Plugins

" Check if plugged exists.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif


call plug#begin()

    " status line
    Plug 'vim-airline/vim-airline'

    " tree file explorer
    Plug 'scrooloose/nerdtree'        

    " pairing utilities
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs' " TODO

    " commenting
    Plug 'scrooloose/nerdcommenter' " TODO
    
    " git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    
    " Visual tabs
    Plug 'Yggdroot/indentLine'

    " text manipulation
    Plug 'godlygeek/tabular'    " tab alignment
    Plug 'tommcdo/vim-exchange' " text swapping

    " autocompletion
"    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'ervandew/supertab'
    Plug 'zchee/deoplete-clang' " TODO
    Plug 'SirVer/ultisnips' " TODO
    Plug 'honza/vim-snippets' " TODO

    " Linting
    Plug 'benekastah/neomake' " TODO

    " REPL messages
    Plug 'metakirby5/codi.vim' " TODO

    " colour schemes
    " Plug 'mhartington/oceanic-next'
    " Plug 'morhetz/gruvbox'
    Plug 'jacoborus/tender'  " Current 

call plug#end()


"" Plugin Configurations

" autocompletion
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/lib/x86_64-linux-gnu/libclang.so"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang/"

" status line
let g:tender_airline = 1
let g:airline_theme='tender'

" colorscheme
colorscheme tender



""" Mappings

" Move along visual lines, not numbered ones.
nnoremap j gj
nnoremap k gk
nnoremap ^ g^
nnoremap $ g$
vnoremap j gj
vnoremap k gk
vnoremap ^ g^
vnoremap $ g$

" Simplify moving across splits. (No more W)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


