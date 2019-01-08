# aliases
alias ls='ls --color=auto'

alias ni=nvim
alias nif='ni $(rg --files | fzf || echo +qa)'
