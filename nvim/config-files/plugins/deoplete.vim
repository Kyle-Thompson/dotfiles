" autocompletion: deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = "/usr/lib/x86_64-linux-gnu/libclang-3.8.so"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang/"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

