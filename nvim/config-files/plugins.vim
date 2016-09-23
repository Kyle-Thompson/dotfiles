" Check if plugged exists.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif


" Plugins to get:
" - easymotion

call plug#begin()

    " status line
    Plug 'vim-airline/vim-airline'

    " tree file explorer
    Plug 'scrooloose/nerdtree'        

    " quotes, brackets, etc. utility
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'

    " commenting
    Plug 'scrooloose/nerdcommenter'   
    
    " git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    
    " Visual tabs
    Plug 'Yggdroot/indentLine'

    " text alignment
    Plug 'godlygeek/tabular'

    " autocompletion
    Plug 'Shougo/deoplete.nvim' ", { 'do': ':UpdateRemotePlugins' }
    Plug 'ervandew/supertab'
    Plug 'zchee/deoplete-clang'

    " Linting
    Plug 'benekastah/neomake'

    " REPL messages
    Plug 'metakirby5/codi.vim'

    " colour schemes
    Plug 'mhartington/oceanic-next'
    Plug 'morhetz/gruvbox'
    Plug 'jacoborus/tender'  " Current 

call plug#end()


"--- Plugin Configurations

" autocompletion
let g:deoplete#enable_at_startup = 1

" status line
let g:tender_airline = 1
let g:airline_theme='tender'

" colorscheme
colorscheme tender

" visual indentaion


