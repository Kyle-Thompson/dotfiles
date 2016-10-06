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


"--- Plugin Configurations

" autocompletion
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/lib/x86_64-linux-gnu/libclang.so"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang/"

" status line
let g:tender_airline = 1
let g:airline_theme='tender'

" colorscheme
colorscheme tender

" visual indentaion

" Move along visual lines, not numbered ones.
nnoremap j gj
nnoremap k gk
nnoremap ^ g^
nnoremap $ g$
vnoremap j gj
vnoremap k gk
vnoremap ^ g^
vnoremap $ g$
" TODO find out if noremap should be used instead

" Simplify moving across splits. (No more W)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


