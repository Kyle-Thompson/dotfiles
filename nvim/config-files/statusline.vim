" ==============================================================================
" ================   StatusLine   ==============================================
" ==============================================================================


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

  if l:counts.total == 0
    let g:linter = ''
  else
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_warnings = l:counts.warnings + l:counts.style_warnings
    let g:linter = printf('%dW %dE ', l:all_warnings, l:all_errors)
  endif
endfunction
autocmd BufRead,TextChanged,TextChangedI,TextChangedP *
  \ call UpdateLinterStatus()
autocmd BufNewFile * let g:linter = ''


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
set statusline+=%{g:linter}   " linter warnings and errors
set statusline+=%l/%L,%c\     " rownumber/total,colnumber
