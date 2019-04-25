" ==============================================================================
" ======================   General   ===========================================
" ==============================================================================

" leader
let mapleader = ' '

" clipboard
set clipboard=unnamedplus  " enable system clipboard

" completion
set wildmode=list:longest

" fill chars
set fillchars+=vert:\| |  " use | for vertical split borders
if has('nvim')
  set fillchars+=eob:\ |  " no ~ for end-of-buffer lines.
endif

" folds

" indentation
set softtabstop=2   " number of spaces to replace tabs by
set shiftwidth=2    " number of spaces for autoindent
set expandtab       " use spaces instead of tabs

" miscelanious
set hidden          " hide file, don't close on file switch
set autoread        " automatically update buffer when file chaged externally
set pumheight=30    " limits popup menu height
set textwidth=80    " length to break lines

" safety files
set noswapfile      " do not create swap files
set nobackup        " do not create backup files

" scrolling
set scrolloff=4     " start scrolling 4 lines from the bottom

" searching
set ignorecase      " ignore case when searching
set smartcase       " match any given captials in search

" shortmess
set shortmess=
set shortmess+=a    " all abbreviations
set shortmess+=c    " no 'match n of m' or 'the only match' messages
set shortmess+=s    " no 'search hit BOTTOM' messages
set shortmess+=W    " no [w] when writing a file
set shortmess+=T    " truncate long messages with '...'
set shortmess+=I    " no intro messages when starting vim

" spliting
set splitbelow      " vertical splits open below current window
set splitright      " horizontal splits open right of the current window

" tags
set tags=./tags;/   " recurse up directories looking for tag files

" visual
set noshowcmd       " don't display partial commands in bottom right
set noshowmode      " don't display mode under statusline (e.g. -- INSERT --)

" wildignore
set wildignore=*.o,*.pyc

" word wrapping
set wrap            " spread long lines across multiple lines
set linebreak       " do not break words on wrap
set nolist          " do not show characters at the end of lines


" ==============================================================================
" ======================   Autocmds   ==========================================
" ==============================================================================

" automatically change the working path to the path of the current file
autocmd BufNewFile,BufEnter * silent! lcd %:p:h
" au BufRead * if search('\M-*- C++ -*-', 'n', 1) | setlocal ft=cpp | endif


" ==============================================================================
" ======================   Mappings   ==========================================
" ==============================================================================

" easy escape to normal
inoremap jj <ESC>

" move along visual lines, not numbered ones
nnoremap j gj
nnoremap k gk
nnoremap ^ g^
nnoremap $ g$
vnoremap j gj
vnoremap k gk
vnoremap ^ g^
vnoremap $ g$

" simplify moving across splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" save when file is readonly
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" show options if tag has multiple matches
nnoremap <C-]> g<C-]>

" clear highlights
nnoremap <silent> <leader>h :nohls<CR>

" pop-up menu navigation
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" ==============================================================================
" ======================   Plugins   ===========================================
" ==============================================================================

" install vim-plug if it's not already
if has('nvim') && empty(glob('~/.config/nvim/autoload/plug.vim'))  " nvim
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $NEOVIMRC
elseif !has('nvim') && empty(glob('~/.vim/autoload/plug.vim'))  " vim
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $VIMRC
endif


call plug#begin()

" ========== completion ========================================================
" ========== language server
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
\ }

let g:LanguageClient_autoStart = 1
let g:LanguageClient_hasSnippetSupport = 1
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_serverCommands = {
  \ 'c':      ['ccls', '--log-file=/tmp/ccls_c.log'],
  \ 'cpp':    ['ccls', '--log-file=/tmp/ccls_cpp.log'],
  \ 'python': ['pyls'],
  \ 'rust':   ['rustup', 'run', 'stable', 'rls'],
  \ 'sh':     ['bash-language-server', 'start'],
\ }

nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lwd :call
  \ LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_references()<CR>

" ========== completion manager
Plug 'ncm2/ncm2'        " completion engine
Plug 'roxma/nvim-yarp'  " needed for ncm2
Plug 'ncm2/ncm2-tmux'   " find completions from tmux panes
Plug 'ncm2/ncm2-path'   " complete filesystem paths

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noinsert,noselect

" ========== snippets
Plug 'SirVer/ultisnips'     " snippet engine
Plug 'honza/vim-snippets'   " default snippets
Plug 'ncm2/ncm2-ultisnips'  " autocompletion support

inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
" ExpandTrigger default conflicts with pum movement
let g:UltiSnipsExpandTrigger = '\<Plug>(placeholder)'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


" ========== searching =========================================================
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


" ========== utilities =========================================================
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

" colorschemes
Plug 'Kyle-Thompson/xresources-colors.vim'
Plug 'chriskempson/base16-vim'

call plug#end()

" set here since colorschemes can't be defined before plug#end()
silent! colorscheme xres


" ==============================================================================
" ====================   StatusLine   ==========================================
" ==============================================================================

" ========== git info ==========================================================
function! GetGitBranch()
  let g:git = system(join([ 'git rev-parse --abbrev-ref HEAD 2> /dev/null',
                          \ 'sed "s/^/git:/"',
                          \ 'tr "\n" " "']
                     \ , '|'))
endfunction
autocmd BufEnter * call GetGitBranch()


" ========== statusline ========================================================
set statusline=
set statusline+=\             " initial leading space
set statusline+=%{g:git}      " git branch name
set statusline+=%<            " trim from here
set statusline+=%f\           " path+filename
set statusline+=%m\           " check modifi{ed,able}
set statusline+=%r\           " check readonly
set statusline+=%w\           " check preview window
set statusline+=%=            " left/right separator
set statusline+=%l/%L,%c\     " rownumber/total,colnumber


" ==============================================================================
" ====================   Overrides   ===========================================
" ==============================================================================

" ========== local settings ====================================================
if !empty(glob('~/.nvim.local.vim'))
  exe 'source' '~/.nvim.local.vim'
endif
