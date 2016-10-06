" ===== neomake =====

" general
autocmd! BufWritePost * Neomake
let g:neomake_verbose = 0
let g:neomake_open_list = 2

" c++
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_args = ['-std=c++1z', '-Wall', '-Wextra', '-fsyntax-only']

" c
let g:neomake_c_enabled_makers = ['clang']
let g:neomake_c_clang_args = ['-std=c11', '-Wall', '-Wextra', '-fsyntax-only']

" python
let g:neomake_python_enable_markers = ['flake8']

