" ========== Plugins ==========
" =============================

" install vim-plug if it's not already
if has('nvim') && empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
elseif empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

  " ===== autocompletion =====
  if has('nvim')
    Plug 'ncm2/ncm2'        " Completion engine
    Plug 'roxma/nvim-yarp'  " Needed for ncm2
    Plug 'ncm2/ncm2-tmux'   " find completions from tmux panes
    Plug 'ncm2/ncm2-path'   " complete filesystem paths

    " general
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=menuone,noinsert,noselect

    " rust
    let g:rustc_path = $HOME.".cargo/bin/rustc"
  endif

  " ===== colorscheme =====
  Plug 'Kyle-Thompson/xresources-colors.vim'
  silent! colorscheme xres

  " commenting
  Plug 'scrooloose/nerdcommenter'

  " file explorer
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

  " fuzzy file searching
  " Plug 'junegunn/fzf', { 'dir': $XDG_DATA_HOME . '/fzf',
  "                      \ 'do': './install --all'}
  " Plug 'junegunn/fzf.vim'

  " languages
  " Plug 'ncm2-pyclang', { 'for': ['c', 'cpp'] }
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }  " Is this needed?
  Plug 'racer-rust/racer', { 'for': 'rust',
                           \ 'do': 'cargo +nightly install racer'}
  Plug 'ncm2/ncm2-racer', { 'for': 'rust'}
  Plug 'ncm2/ncm2-jedi', { 'for': 'python' }
  " Plug 'lervag/vimtext', { 'for': 'tex' }

  " linting and fixing
  Plug 'w0rp/ale'

  " movement
  Plug 'easymotion/vim-easymotion'

  " pairing utilities
  Plug 'tpope/vim-surround'    " wrap text with new pair
  Plug 'jiangmiao/auto-pairs'  " create new empty pair

  " repeat
  Plug 'tpope/vim-repeat'  " '.' repeats last plugin op

  " REPL messages
  Plug 'metakirby5/codi.vim', { 'for': 'python' }  " TODO

  " snippets
  " Plug 'ncm2/ncm2-ultisnips'
  " Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

  " text
  " Plug 'godlygeek/tabular'     " alignment
  Plug 'tommcdo/vim-exchange'  " swapping
  Plug 'wellle/targets.vim'    " objects

  " transparency
  Plug 'miyakogi/seiya.vim'

call plug#end()




" ===== commenting =====
let g:NERDSpaceDelims = 1



" ===== file explorer =====
nnoremap <leader>n :NERDTree<CR>
" TODO function to auto-close when nerdtree is the only buffer left



" ===== linting and fixing =====
" general
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \ 'python': ['flake8'],
\ }

let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \ 'python': ['yapf'],
\ }

" python
let g:ale_python_flake8_args="--ignore=W0511"


" ===== transparency =====
let g:seiya_auto_enable=1
let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']
