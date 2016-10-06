" ========== General ==========
" =============================

" Leader
let mapleader = ',' " Set mapleader to ,

" Completion
set wildmode=list:longest
set wildmenu
set wildignore=*.o

" Folds (TODO learn)

" Indentation
set tabstop=4       " A tab is 4 spaces wide
set softtabstop=4   " Number of spaces to replace tabs by
set shiftwidth=4    " Number of spaces for autoindent
set expandtab       " Use spaces instead of tabs (Insert mode)
set smarttab        " Go to next tabstop when tab pressed (Insert mode)
set smartindent     " Use proper indentation for filetype

" Miscelanious
set hidden          " Hide file, don't close on file switch
set visualbell      " No beeps

" Safety files
set noswapfile      " Do not create swap files
set nobackup        " Do not create backup files

" Scrolling
set scrolloff=4     " Start scrolling 4 lines from the bottom.

" Searching
set ignorecase      " Ignore case when searching
set smartcase       " Match any given captials in search
set incsearch       " Highlight matches in real time
set hlsearch        " Highlight previous searches

" Spliting
set splitbelow      " Vertical splits open below current window
set splitright      " Horizontal splits open right of the current window

" Visual
set number          " Show line numbers
set relativenumber  " Line numbers are relative to current line
set cursorline      " Highlight cursorline
syntax enable       " Syntax highlighting
set termguicolors   " Enable true colours

" Word wrapping
set wrap            " Spread long lines across multiple lines
set linebreak       " Do not break words on wrap
set nolist          " Do not show characters at the end of lines (needed for linebreak)


" ========== Plugins ==========
" =============================

" watchlist:
" - incsearch.vim

" install vim-plug if it's not already
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin()

    " autocompletion
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocomplete system
    Plug 'ervandew/supertab'    " TODO
    Plug 'zchee/deoplete-clang' " TODO

    " colourscheme
    Plug 'jacoborus/tender'

    " commenting
    Plug 'scrooloose/nerdcommenter'

    " file explorer
    Plug 'scrooloose/nerdtree'

    " fuzzy file searching
    Plug 'ctrlpvim/ctrlp.vim'

    " git
    Plug 'tpope/vim-fugitive'     " command-line git wrapper
    Plug 'airblade/vim-gitgutter' " git changes in the gutter

    " language pack
    Plug 'sheerun/vim-polyglot'

    " linting
    Plug 'neomake/neomake'

    " movement
    Plug 'easymotion/vim-easymotion'

    " pairing utilities
    Plug 'tpope/vim-surround'   " wrap text with new pair
    Plug 'jiangmiao/auto-pairs' " create new empty pair

    " REPL messages
    Plug 'metakirby5/codi.vim' " TODO

    " visual tabs
    Plug 'Yggdroot/indentLine'

    " snippets
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

    " status line
    Plug 'vim-airline/vim-airline'

    " text
    Plug 'godlygeek/tabular'    " alignment
    Plug 'tommcdo/vim-exchange' " swapping
    Plug 'wellle/targets.vim'   " objects

call plug#end()


" autocompletion: deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/lib/x86_64-linux-gnu/libclang-3.8.so"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang/"

" colorscheme
silent! colorscheme tender

" file explorer
nnoremap <leader>n :NERDTree<CR>
" TODO function to auto-close when nerdtree is the only buffer left

" linter: neomake: general
autocmd! BufWritePost * Neomake
let g:neomake_verbose = 0
let g:neomake_open_list = 2
" linter: neomake: c++
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_args = ['-std=c++1z', '-Wall', '-Wextra', '-fsyntax-only']
" linter: neomake: c
let g:neomake_c_enabled_makers = ['clang']
let g:neomake_c_clang_args = ['-std=c11', '-Wall', '-Wextra', '-fsyntax-only']
" linter: neomake: python
let g:neomake_python_enable_markers = ['flake8']

" movement
" map <leader>m <Plug>(easymotion-prefix)

" status line
let g:tender_airline = 1
let g:airline_theme='tender'



" ========== Mappings =========
" =============================

" Easy escape to normal
inoremap jj <ESC>

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


