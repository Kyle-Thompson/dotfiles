" ==============================================================================
" ================   StatusLine   ==============================================
" ==============================================================================


" ========== mode ==============================================================
let g:currentmode={
  \ 'n'  : 'N',
  \ 'no' : 'N_Operator Pending',
  \ 'v'  : 'V',
  \ 'V'  : 'V_Line',
  \ '^V' : 'V_Block',
  \ 's'  : 'Select',
  \ 'S'  : 'S_Line',
  \ '^S' : 'S_Block',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'Rv' : 'V_Replace',
  \ 'c'  : 'C',
  \ 'cv' : 'Vim Ex',
  \ 'ce' : 'Ex',
  \ 'r'  : 'Prompt',
  \ 'rm' : 'More',
  \ 'r?' : 'Confirm',
  \ '!'  : 'SH',
  \ 't'  : 'TERM'
\}

function! GetMode()
  return g:currentmode[mode()].' '
endfunction


" ========== git info ==========================================================
let g:git = system(join(['git rev-parse --abbrev-ref HEAD 2> /dev/null',
                        \'sed "s/^/git:/"',
                        \'tr -d "\n"']
                   \ , '|'))
function! GitInfo()
  return g:git != '' ? g:git.' ' : ''
endfunction


" ========== statusline ========================================================
set laststatus=2
set statusline=
set statusline+=\ %{GetMode()}  " current mode
set statusline+=%{GitInfo()}  " git branch name
set statusline+=%<            " trim from here
set statusline+=%f\           " path+filename
set statusline+=%m\           " check modifi{ed,able}
set statusline+=%r\           " check readonly
set statusline+=%w\           " check preview window
set statusline+=%=            " left/right separator
set statusline+=%y\           " fileType
set statusline+=%l/%L,%c\     " rownumber/total,colnumber


" ========== colors ============================================================
hi statusline guifg=#7ea2b4 guibg=#161b1d
