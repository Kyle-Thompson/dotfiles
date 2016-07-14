" :source init/configurations.vim
" :source init/plugins.vim

for f in split(glob('~/.config/nvim/init/*.vim'), '\n')
    exe 'source' f
endfor
