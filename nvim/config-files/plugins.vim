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


for f in split(glob('~/.config/nvim/config-files/plugins/*.vim'), '\n')
    exe 'source' f
endfor

