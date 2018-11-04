# prompt

# git status
autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' actionformats '[%F{2}%b %F{1}%a%f] '
zstyle ':vcs_info:*' formats '[%F{2}%b%f] '
precmd () { vcs_info }
prompt='%1~ ${vcs_info_msg_0_}%f> '
