" ========== Plugins ==========
" =============================

" install vim-plug if it's not already
if has('nvim') && empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
elseif !has('nvim') && empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

  " ===== autocompletion =====
  if has('nvim') || version >= 800
    Plug 'ncm2/ncm2'        " completion engine
    Plug 'roxma/nvim-yarp'  " needed for ncm2
    Plug 'ncm2/ncm2-tmux'   " find completions from tmux panes
    Plug 'ncm2/ncm2-path'   " complete filesystem paths

    " general
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=menuone,noinsert,noselect

    " cpp
    Plug 'ncm2/ncm2-pyclang'
    let g:ncm2_pyclang#library_path = $LIBCLANG_DIR

    " python
    Plug 'ncm2/ncm2-jedi'

    " rust
    Plug 'rust-lang/rust.vim'
    Plug 'racer-rust/racer', { 'do': 'cargo +nightly install racer' }
    Plug 'ncm2/ncm2-racer'
    let g:rustc_path = $HOME.".cargo/bin/rustc"
  endif


  " ===== colorscheme =====
  Plug 'Kyle-Thompson/xresources-colors.vim'


  " ===== linting and fixing =====
  Plug 'w0rp/ale'

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


  " ===== repeat =====
  Plug 'tpope/vim-repeat'  " '.' repeats last plugin op


  " ===== searching =====
  Plug 'junegunn/fzf', { 'dir': $HOME . '/.config/fzf', 'do': './install --all'}
  Plug 'junegunn/fzf.vim'
  nnoremap <leader>f :Files<CR>
  nnoremap <leader>b :Buffers<CR>

  Plug 'jremmen/vim-ripgrep'
  nnoremap <leader>g :Rg<CR>

  Plug 'easymotion/vim-easymotion'
  map <leader>e <Plug>(easymotion-prefix)

  Plug 'haya14busa/incsearch.vim'
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  Plug 'haya14busa/incsearch-easymotion.vim'
  map z/ <Plug>(incsearch-easymotion-/)
  map z? <Plug>(incsearch-easymotion-?)
  map zg/ <Plug>(incsearch-easymotion-stay)


  " ===== snippets =====
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'ncm2/ncm2-ultisnips'


  " ===== tags =====
  Plug 'majutsushi/tagbar'
  if has('nvim') || version >= 800
    Plug 'ludovicchabant/vim-gutentags'
  endif


  " ===== text =====
  Plug 'wellle/targets.vim'    " objects
  Plug 'tommcdo/vim-exchange'  " swapping
  Plug 'tpope/vim-surround'    " wrapping
  Plug 'jiangmiao/auto-pairs'  " creating pairs
  Plug 'tpope/vim-commentary'  " commenting


  " ===== transparency =====
  Plug 'miyakogi/seiya.vim'
  let g:seiya_auto_enable=1
  let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']

call plug#end()

" set here since colorschemes can't be defined before plug#end()
silent! colorscheme xres
