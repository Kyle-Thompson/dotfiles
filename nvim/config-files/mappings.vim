" ========== Mappings =========
" =============================

" Easy escape to normal.
inoremap jj <ESC>

" Move along visual lines, not numbered ones.
nnoremap j gj
nnoremap k gk
nnoremap ^ g^
nnoremap $ g$
vnoremap j gj
vnoremap k gk
vnoremap ^ g^
vnoremap $ g$

" Simplify moving across splits. (No more W)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" HJKL movement in insert mode.
inoremap <C-J> <ESC><Down><Right>i
inoremap <C-K> <ESC><Up><Right>i
inoremap <C-L> <ESC><Right><Right>i
inoremap <C-H> <ESC>i
