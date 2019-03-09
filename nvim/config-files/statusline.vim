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
