"--- Configurations

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
set copyindent      " TODO

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

" Visual
set number          " Show line numbers.
set cursorline      " Highlight cursorline.
syntax on           " Syntax highlighting
syntax enable       " TODO
set background=dark " TODO
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Uncatagorized (TODO: for now)
set hidden          " Hide file, don't close on file switch. 
set visualbell      " No beeps.


"--- Plugins

" Check if plugged exists.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin() "'~/.config/nvim/plugged')
    
    " status line
    Plug 'vim-airline/vim-airline'

    " tree file explorer
    Plug 'scrooloose/nerdtree'        
    
    " commenting utility
    Plug 'scrooloose/nerdcommenter'   
    
    " git wrapper
    Plug 'tpope/vim-fugitive'         
    
    " Visual tabs
    Plug 'Yggdroot/indentLine'

    " text alignment
    Plug 'godlygeek/tabular'          

    " autocompletion
    function! DoRemote(arg) " TODO: find out if this is necessary
        UpdateRemotePlugins
    endfunction
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

    " colour schemes
    Plug 'mhartington/oceanic-next'
    Plug 'morhetz/gruvbox'  " Current

call plug#end()


"--- Plugin Configurations

" autocompletion
let g:deoplete#enable_at_startup = 1

" status line
let g:airline_theme='gruvbox'

" colorscheme
colorscheme gruvbox

" visual indentaion


