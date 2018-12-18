for f in split(glob('~/.config/nvim/config-files/*.vim'), '\n')
    exe 'source' f
endfor

if !empty(glob("~/.nvim.local"))
  exe 'source' "~/.nvim.local"
endif
