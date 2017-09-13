# prompt
if [ $(tput colors) -ge "256" ]; then
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
    POWERLEVEL9K_STATUS_VERBOSE=false
    source ~/.dotfiles/zsh/powerlevel9k/powerlevel9k.zsh-theme
else
    prompt="%1~ > "
fi
