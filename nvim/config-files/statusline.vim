" ========= StatusLine ========
" =============================

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

function! ReadOnly()
  return &readonly || !&modifiable ? ' RO' : ''
endfunction

let g:is_git_dir = system('echo -n $(git rev-parse --is-inside-work-tree)')
let g:git = system('echo -n $(git rev-parse --abbrev-ref HEAD)')
function! GitInfo()
  return g:is_git_dir == 'true' ? 'git:'.g:git : ''
endfunction

set laststatus=2
set statusline=
set statusline+=%0*\ %{g:currentmode[mode()]}   " current mode
set statusline+=%8*\ %{GitInfo()}               " git branch name
set statusline+=%8*\ %<%f%{ReadOnly()}\ %m\ %w  " file+path
set statusline+=%#warningmsg#                   " warning messages
set statusline+=%9*\ %=                         " space
set statusline+=%8*\ %y\                        " fileType
set statusline+=%8*%l/%L,%c\                    " rownumber/total,colnumber

hi User1 ctermfg=007
hi User2 ctermfg=008
hi User3 ctermfg=008
hi User4 ctermfg=008
hi User5 ctermfg=008
hi User7 ctermfg=008
hi User8 ctermfg=008
hi User9 ctermfg=007
