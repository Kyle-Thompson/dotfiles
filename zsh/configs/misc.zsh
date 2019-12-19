# Use emacs keybindings.
bindkey -v

# Do not force prompt to start on a newline.
setopt NOPROMPT_CR

# Allow a comment as a zsh command.
setopt interactivecomments

# Easily cd to certain directories
setopt auto_cd
cdpath=($HOME/.dotfiles)
