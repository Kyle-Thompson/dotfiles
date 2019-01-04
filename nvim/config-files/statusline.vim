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
\ }

function! GetMode()
  return g:currentmode[mode()].' '
endfunction


" ========== git info ==========================================================
function! GetGitBranch()
  let g:git = system(join([ 'git rev-parse --abbrev-ref HEAD 2> /dev/null',
                          \ 'sed "s/^/git:/"',
                          \ 'tr "\n" " "']
                     \ , '|'))
endfunction
autocmd BufEnter * call GetGitBranch()


" ========== ale ===============================================================
function! UpdateLinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error

  let g:linter =
    \ l:counts.total == 0
    \ ? ''
    \ : join(
        \ '%#Error#',
        \ printf('%dW %dE ', l:counts.total - l:all_errors, l:all_errors),
        \ '%#Normal#')
endfunction
autocmd BufEnter,TextChanged,TextChangedI,TextChangedP *
  \ call UpdateLinterStatus()


" ========== statusline ========================================================
set laststatus=2
set statusline=
set statusline+=\             " initial leading space
set statusline+=%{GetMode()}  " current mode
set statusline+=%{g:git}      " git branch name
set statusline+=%<            " trim from here
set statusline+=%f\           " path+filename
set statusline+=%m\           " check modifi{ed,able}
set statusline+=%r\           " check readonly
set statusline+=%w\           " check preview window
set statusline+=%=            " left/right separator
set statusline+=%{g:linter}   " linter warnings and errors
set statusline+=%l/%L,%c\     " rownumber/total,colnumber

hi statusline guifg=#7ea2b4 guibg=#161b1d
