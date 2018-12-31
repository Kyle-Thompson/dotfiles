" ==============================================================================
" ================   StatusLine   ==============================================
" ==============================================================================

let g:currentmode={
  \ 'n'  : 'N ',
  \ 'no' : 'N_Operator Pending ',
  \ 'v'  : 'V ',
  \ 'V'  : 'V_Line ',
  \ '^V' : 'V_Block ',
  \ 's'  : 'Select ',
  \ 'S'  : 'S_Line ',
  \ '^S' : 'S_Block ',
  \ 'i'  : 'I ',
  \ 'R'  : 'R ',
  \ 'Rv' : 'V_Replace ',
  \ 'c'  : 'C ',
  \ 'cv' : 'Vim Ex ',
  \ 'ce' : 'Ex ',
  \ 'r'  : 'Prompt ',
  \ 'rm' : 'More ',
  \ 'r?' : 'Confirm ',
  \ '!'  : 'SH',
  \ 't'  : 'TERM'
\}


" ========== read only =========================================================
function! ReadOnly()
  return &readonly || !&modifiable ? ' RO' : ''
endfunction


" ========== git info ==========================================================
let g:git = system(join(['git rev-parse --abbrev-ref HEAD 2> /dev/null',
                        \ 'sed "s/^/git:/"',
                        \ 'tr -d "\n"']
                   \ , "|"))
function! GitInfo()
  return g:git
endfunction


" ========== statusline ========================================================
set laststatus=2
set statusline=
set statusline+=%0*\ %{g:currentmode[mode()]}   " current mode
set statusline+=%8*\ %{GitInfo()}               " git branch name
set statusline+=%8*\ %<%f%{ReadOnly()}\ %m\ %w  " file+path
set statusline+=%#warningmsg#                   " warning messages
set statusline+=%9*\ %=                         " space
set statusline+=%8*\ %y\                        " fileType
set statusline+=%8*%l/%L,%c\                    " rownumber/total,colnumber


" ========== colors ============================================================
hi User1 ctermfg=007
hi User2 ctermfg=008
hi User3 ctermfg=008
hi User4 ctermfg=008
hi User5 ctermfg=008
hi User7 ctermfg=008
hi User8 ctermfg=008
hi User9 ctermfg=007
