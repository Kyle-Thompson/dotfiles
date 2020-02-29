" ==============================================================================
" ======================   General   ===========================================
" ==============================================================================

" leader
let mapleader = ' '

" clipboard
set clipboard=unnamedplus  " enable system clipboard

" completeopt
" menuone   - pum even for a single match
" noinstert - no text insterted until selection
" noselect  - no auto selection
set completeopt=menuone,noinsert,noselect

" fill chars
set fillchars+=vert:\| |  " use | for vertical split borders
set fillchars+=eob:\   |  " no ~ for end-of-buffer lines.

" folds

" indentation
set softtabstop=2   " number of spaces to replace tabs by
set shiftwidth=2    " number of spaces for autoindent
set expandtab       " use spaces instead of tabs

" miscellaneous
colorscheme xres    " set colorscheme
set hidden          " hide file, don't close on file switch
set autoread        " automatically update buffer when file chaged externally
set pumheight=30    " limits popup menu height
set textwidth=80    " length to break lines

" netrw
let g:netrw_dirhistmax = 0  " no netrwhist file
let g:netrw_banner = 0      " no top comments

" plugins
set packpath=~/.config/nvim/

" safety files
set noswapfile      " do not create swap files
set nobackup        " do not create backup files

" scrolling
set scrolloff=4     " start scrolling 4 lines from the bottom

" searching
set ignorecase      " ignore case when searching
set smartcase       " match any given captials in search

" shortmess
" a - all abbreviations
" c - no 'match n of m' or 'the only match' messages
" s - no 'search hit BOTTOM' messages
" W - no [w] when writing a file
" T - truncate long messages with '...'
" I - no intro messages when starting vim
" F - no prompt when opening multiple files
set shortmess=acsWTIF

" spliting
set splitbelow      " vertical splits open below current window
set splitright      " horizontal splits open right of the current window

" visual
set noshowcmd       " don't display partial commands in bottom right
set noshowmode      " don't display mode under statusline (e.g. -- INSERT --)

" wildmenu
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

packadd ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd BufEnter * call GetGitBranch()


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

" keep visual selection when (de)indenting
vmap < <gv
vmap > >gv

" simplify moving across splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" save when file is readonly
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" clear highlights
nnoremap <silent> <leader>h :nohls<CR>

" pop-up menu navigation
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" plugin majutsushi/tagbar
nnoremap <silent> <leader>t :TagbarToggle<CR><C-W>=

" plugin junegunn/vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" plugin easymotion/vim-easymotion
map <leader>w <Plug>(easymotion-bd-w)
map <leader>c <Plug>(easymotion-s)

" plugin haya14busa/incsearch.vim
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" plugin ncm2/ncm2-ultisnips
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" plugin junegunn/fzf.vim
nnoremap <leader>ff  :Files<CR>
nnoremap <leader>fb  :Buffers<CR>
nnoremap <leader>fp  :exec 'Files' b:LanguageClient_projectRoot<CR>
nnoremap <leader>fl  :Lines<CR>
nnoremap <leader>fbl :BLines<CR>


" ==============================================================================
" ======================   Plugins   ===========================================
" ==============================================================================

packadd nvim-lsp

lua << EOF
local nvim_lsp = require('nvim_lsp')
local ncm2 = require('ncm2')
nvim_lsp.clangd.setup{
  cmd = {'clangd', '--background-index', '--clang-tidy', '--log=error',
         '--pretty'};
  on_init = ncm2.register_lsp_source;
}

-- disable signs
do
  local util = require 'vim.lsp.util'
  vim.lsp.callbacks['textDocument/publishDiagnostics'] = function(_, _, result)
    if not result then return end
    local uri = result.uri
    local bufnr = vim.uri_to_bufnr(uri)
    if not bufnr then
      err_message("LSP.publishDiagnostics: Couldn't find buffer for ", uri)
      return
    end
    util.buf_clear_diagnostics(bufnr)
    util.buf_diagnostics_save_positions(bufnr, result.diagnostics)
    util.buf_diagnostics_underline(bufnr, result.diagnostics)
    util.buf_diagnostics_virtual_text(bufnr, result.diagnostics)
    vim.api.nvim_command("doautocmd User LspDiagnosticsChanged")
  end
end
EOF

nnoremap <silent> <leader>ld  <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>lwd <cmd>sp<CR>:lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>li  <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>lh  <cmd>lua vim.lsp.buf.hover()<CR>


" ========== snippets
let g:UltiSnipsExpandTrigger = '\<Plug>(placeholder)'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


" ========== searching
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
\ }


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
