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


  " ===== commenting =====
  Plug 'tpope/vim-commentary'


  " ===== fuzzy file searching =====
  Plug 'junegunn/fzf', { 'dir': $HOME . '/.config/fzf',
                       \ 'do': './install --all'}
  Plug 'junegunn/fzf.vim'
  nnoremap <leader>f :Files<CR>
  nnoremap <leader>b :Buffers<CR>


  " ===== languages =====
  " TODO: determine if all 3 rust plugins are necessary.
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'racer-rust/racer', { 'for': 'rust',
                           \ 'do': 'cargo +nightly install racer'}
  Plug 'ncm2/ncm2-racer', { 'for': 'rust'}
  Plug 'ncm2/ncm2-jedi', { 'for': 'python' }


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



  " ===== movement =====
  Plug 'easymotion/vim-easymotion'


  " ===== repeat =====
  Plug 'tpope/vim-repeat'  " '.' repeats last plugin op


  " ===== snippets =====
  Plug 'ncm2/ncm2-ultisnips'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'


  " ===== tags =====
  Plug 'majutsushi/tagbar'
  if has('nvim') || version >= 800
    " TODO: only load if tag file exists.
    Plug 'ludovicchabant/vim-gutentags'
  endif


  " ===== text =====
  Plug 'wellle/targets.vim'    " objects
  Plug 'tommcdo/vim-exchange'  " swapping
  Plug 'tpope/vim-surround'    " wrapping
  Plug 'jiangmiao/auto-pairs'  " creating pairs


  " ===== transparency =====
  Plug 'miyakogi/seiya.vim'
  let g:seiya_auto_enable=1
  let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']

call plug#end()
