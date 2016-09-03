for f in split(glob('~/.config/nvim/config-files/*.vim'), '\n')
    exe 'source' f
endfor
