# prompt

# git status
autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{3}'
zstyle ':vcs_info:*' stagedstr '%F{4}'
zstyle ':vcs_info:*' actionformats '[%F{2}%c%u%b %F{1}%a%f] '
zstyle ':vcs_info:*' formats '[%F{2}%c%u%b%f] '
precmd () { vcs_info }
prompt='%1~ ${vcs_info_msg_0_}%f> '
