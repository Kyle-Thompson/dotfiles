" ==============================================================================
" ==================   Mappings   ==============================================
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
nnoremap <leader>c :nohls<CR>
