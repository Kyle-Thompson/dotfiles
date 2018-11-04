# prompt

### GIT - BEGIN
autoload -Uz vcs_info
setopt prompt_subst

# Only check for git. This might have some performance benefits.
zstyle ':vcs_info:*' enable git

# Needed for checking if {un}staged files exist.
zstyle ':vcs_info:*' check-for-changes true

# Formatting when {un}staged files exist in the branch.
zstyle ':vcs_info:*' unstagedstr '%F{3}'
zstyle ':vcs_info:*' stagedstr '%F{4}'

# Formatting for the git prompt if in a repo.
zstyle ':vcs_info:*' actionformats '[%F{2}%c%u%b %F{1}%a%f] '
zstyle ':vcs_info:*' formats '[%F{2}%c%u%b%f] '
### GIT - END


precmd () { vcs_info }
prompt='%1~ ${vcs_info_msg_0_}%f> '
