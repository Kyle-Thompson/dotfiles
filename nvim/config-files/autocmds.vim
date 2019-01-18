" ==============================================================================
" ==================   Autocmds   ==============================================
" ==============================================================================

" automatically change the working path to the path of the current file
autocmd BufNewFile,BufEnter * silent! lcd %:p:h
au BufRead * if search('\M-*- C++ -*-', 'n', 1) | setlocal ft=cpp | endif
