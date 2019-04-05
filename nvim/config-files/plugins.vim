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

let s:async = has('nvim') || has('job')


call plug#begin()

  " ========== autocompletion ==================================================
  if s:async && has('python3')
    Plug 'ncm2/ncm2'        " completion engine
    Plug 'roxma/nvim-yarp'  " needed for ncm2
    Plug 'ncm2/ncm2-tmux'   " find completions from tmux panes
    Plug 'ncm2/ncm2-path'   " complete filesystem paths

    " general
    autocmd BufEnter * call ncm2#enable_for_buffer()
    set completeopt=menuone,noinsert,noselect
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  endif


  " ========== colorscheme =====================================================
  Plug 'Kyle-Thompson/xresources-colors.vim'
  Plug 'chriskempson/base16-vim'


  " ========== language server =================================================
  if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
    \ }

    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_serverCommands = {
      \ 'c':      ['ccls', '--log-file=/tmp/ccls_c.log'],
      \ 'cpp':    ['ccls', '--log-file=/tmp/ccls_cpp.log'],
      \ 'python': ['pyls'],
      \ 'rust':   ['rustup', 'run', 'stable', 'rls'],
      \ 'sh':     ['bash-language-server', 'start'],
    \ }
  endif

  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lwd :call
    \ LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>lwr :call
    \ LanguageClient#textDocument_references({'gotoCmd': 'split'})<CR>


  " ========== searching =======================================================
  Plug 'junegunn/fzf', { 'dir': $HOME.'/.config/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  nnoremap <leader>ff  :Files<CR>
  nnoremap <leader>fb  :Buffers<CR>
  nnoremap <leader>fp  :exec 'Files' b:LanguageClient_projectRoot<CR>
  nnoremap <leader>ft  :Tags<CR>
  nnoremap <leader>fbt :BTags<CR>
  nnoremap <leader>fl  :Lines<CR>
  nnoremap <leader>fbl :BLines<CR>
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit',
  \ }
  " TODO <ctrl-d> -> (buffer only) delete selected buffer w/o switching buffers

  Plug 'jremmen/vim-ripgrep'
  nnoremap <leader>g :Rg<CR>

  Plug 'easymotion/vim-easymotion'
  map <leader>w <Plug>(easymotion-bd-w)
  map <leader>c <Plug>(easymotion-s)

  Plug 'haya14busa/incsearch.vim'
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)


  " ========== snippets ========================================================
  if s:async && has('python3')
    Plug 'SirVer/ultisnips'     " snippet engine
    Plug 'ncm2/ncm2-ultisnips'  " autocompletion support
  endif

  let g:UltiSnipsExpandTrigger       = '<tab>'
  let g:UltiSnipsJumpForwardTrigger  = '<tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


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
  let g:seiya_auto_enable = 1

call plug#end()

" set here since colorschemes can't be defined before plug#end()
silent! colorscheme xres
