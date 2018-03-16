" ========== Plugins ==========
" =============================

" install vim-plug if it's not already
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin()

    " autocompletion
    Plug 'roxma/nvim-completion-manager'  " Completion engine
    " Plug 'rust-lang/rust.vim'             " (Included in polyglot)
    Plug 'racer-rust/vim-racer'           " TODO
    Plug 'roxma/nvim-cm-racer'            " TODO

    " colourscheme
    Plug 'Kyle-Thompson/xresources-colors.vim'

    " commenting
    Plug 'scrooloose/nerdcommenter'

    " file explorer
    Plug 'scrooloose/nerdtree'

    " fuzzy file searching
    Plug 'junegunn/fzf', { 'dir': $XDG_DATA_HOME . '/fzf',
                         \ 'do': './install --all'}
    Plug 'junegunn/fzf.vim'

    " git
    Plug 'tpope/vim-fugitive'     " command-line git wrapper
    " Plug 'airblade/vim-gitgutter' " git changes in the gutter

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

    " snippets TODO actually make use of this.
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

    " text
    Plug 'godlygeek/tabular'    " alignment
    Plug 'tommcdo/vim-exchange' " swapping
    Plug 'wellle/targets.vim'   " objects

    " transparency
    Plug 'miyakogi/seiya.vim'

call plug#end()


" Source all plugin config files
for f in split(glob('~/.config/nvim/config-files/plugins/*.vim'), '\n')
    exe 'source' f
endfor

