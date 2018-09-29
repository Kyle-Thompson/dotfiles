" ========= StatusLine ========
" =============================

let g:currentmode={
    \ 'n'  : 'N ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'V ',
    \ 'V'  : 'V·Line ',
    \ '^V' : 'V·Block ',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '^S' : 'S·Block ',
    \ 'i'  : 'I ',
    \ 'R'  : 'R ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'C ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
    \ 't'  : 'Terminal '
    \}

function! ReadOnly()
  if &readonly || !&modifiable
    return 'RO'
  else
    return ''
endfunction

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return 'git:'.fugitive#head()
  else
    return ''
endfunction

set laststatus=2
set statusline=
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}  " Current mode
set statusline+=%8*\ %{GitInfo()}                       " Git Branch name
set statusline+=%8*\ %<%f%{ReadOnly()}\ %m\ %w          " File+path
set statusline+=%#warningmsg#                           " Warning messages
set statusline+=%9*\ %=                                 " Space
set statusline+=%1*\ [%n]                               " buffernr
set statusline+=%8*\ %y\                                " FileType
set statusline+=%8*%l/%L,%c\                            " Rownumber/total,Colnumber

hi User1 ctermfg=007
hi User2 ctermfg=008
hi User3 ctermfg=008
hi User4 ctermfg=008
hi User5 ctermfg=008
hi User7 ctermfg=008
hi User8 ctermfg=008
hi User9 ctermfg=007
