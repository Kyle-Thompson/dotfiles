" ==============================================================================
" ==================   Plugins   ===============================================
" ==============================================================================

" install vim-plug if it's not already
if has('nvim') && empty(glob('~/.config/nvim/autoload/plug.vim'))  " nvim
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
elseif !has('nvim') && empty(glob('~/.vim/autoload/plug.vim'))  " vim
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

  " ========== autocompletion ==================================================
  if has('nvim') || has('job')
    Plug 'ncm2/ncm2'        " completion engine
    Plug 'roxma/nvim-yarp'  " needed for ncm2
    Plug 'ncm2/ncm2-tmux'   " find completions from tmux panes
    Plug 'ncm2/ncm2-path'   " complete filesystem paths

    " general
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=menuone,noinsert,noselect
  endif


  " ========== colorscheme =====================================================
  Plug 'Kyle-Thompson/xresources-colors.vim'


  " ========== language server =================================================
  if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
    \ }

    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_serverCommands = {
      \ 'c': ['ccls', '--log-file=/tmp/ccls_c.log'],
      \ 'cpp': ['ccls', '--log-file=/tmp/ccls_cpp.log'],
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }
  endif


  " ========== linting & fixing ================================================
  if has('nvim') || has('job')
    Plug 'w0rp/ale'

    " general
    let g:ale_echo_msg_format = '[%linter%] (%severity%) %code%: %s'

    " linters
    let g:ale_linters_explicit = 1
    let g:ale_linters = {
      \ 'cpp': ['clang', 'clangtidy', 'cppcheck'],
      \ 'python': ['flake8'],
    \ }

    " fixers
    let g:ale_fix_on_save = 1
    let g:ale_fixers = {
      \ 'python': ['yapf'],
    \ }

    " cpp
    let g:ale_cpp_clang_executable = 'clang++'
    let g:ale_cpp_clang_options = '-std=c++14 -Wall'
    let g:ale_cpp_clangtidy_options = '-std=c++14 -x c++'

    " python
    let g:ale_python_flake8_args = '--ignore=W0511'
  endif


  " ========== searching =======================================================
  Plug 'junegunn/fzf', { 'dir': $HOME.'/.config/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  nnoremap <leader>f :Files<CR>
  nnoremap <leader>b :Buffers<CR>

  Plug 'jremmen/vim-ripgrep'
  nnoremap <leader>g :Rg<CR>

  Plug 'easymotion/vim-easymotion'
  map <leader><leader> <Plug>(easymotion-prefix)

  Plug 'haya14busa/incsearch.vim'
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  Plug 'haya14busa/incsearch-easymotion.vim'
  map z/ <Plug>(incsearch-easymotion-/)
  map z? <Plug>(incsearch-easymotion-?)
  map zg/ <Plug>(incsearch-easymotion-stay)


  " ========== snippets ========================================================
  Plug 'SirVer/ultisnips'     " snippet engine
  Plug 'honza/vim-snippets'   " snippet collection
  Plug 'ncm2/ncm2-ultisnips'  " autocompletion support

  let g:UltiSnipsExpandTrigger='<tab>'
  let g:UltiSnipsJumpForwardTrigger='<tab>'
  let g:UltiSnipsJumpBackwardTrigger='<s-tab>'


  " ========== utilities =======================================================
  Plug 'wellle/targets.vim'       " extra text objects
  Plug 'tommcdo/vim-exchange'     " text swapping
  Plug 'tpope/vim-surround'       " wrapping text with pairs
  Plug 'jiangmiao/auto-pairs'     " creating pairs
  Plug 'tpope/vim-commentary'     " commenting
  Plug 'tpope/vim-repeat'         " repeatable plugins
  Plug 'majutsushi/tagbar'        " show file tags in sidebar

  Plug 'junegunn/vim-easy-align'  " text alignment
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

  Plug 'miyakogi/seiya.vim'       " background transparency
  let g:seiya_auto_enable=1
  let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']

call plug#end()

" set here since colorschemes can't be defined before plug#end()
silent! colorscheme xres
