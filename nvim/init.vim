for f in split(glob('~/.config/nvim/init/*.vim'), '\n')
    exe 'source' f
endfor
