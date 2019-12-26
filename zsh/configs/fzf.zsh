# Setup fzf
# ---------
if [[ ! "$PATH" == */home/kyle/.config/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/kyle/.config/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/kyle/.config/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/kyle/.config/fzf/shell/key-bindings.zsh"
