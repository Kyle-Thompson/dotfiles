# prompt
#if [ $(tput colors) -ge "256" ]; then
#    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
#    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
#    POWERLEVEL9K_STATUS_VERBOSE=false
#    source ~/.dotfiles/zsh/powerlevel9k/powerlevel9k.zsh-theme
#else
#    prompt="%1~ > "
#fi

# git status
autoload -Uz vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true

zstyle ':vcs_info:*' enable git
#zstyle ':vcs_info:git*' formats "[(%b)%m%u%c] "
zstyle ':vcs_info:git*' formats "[(%b)%m%c] "
zstyle ':vcs_info:git*' actionformats "[(%b|%a)%m%c] "
#zstyle ':vcs_info:*+*:*' debug true # temp for debugging
precmd() {
    vcs_info
}

# Report existence of untracked files
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
function +vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null; then
        hook_com[staged]+=' ?'
    fi
}

# Report status relative to remote HEAD. (ahead-of or behind by # commits)
# TODO: Get this to work!
# zstyle ':vcs_info:git*+set-message:*' hooks git-st
function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    (( $ahead )) && gitstatus+=( "+${ahead}" )

    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    (( $behind )) && gitstatus+=( "-${behind}" )

    hook_com[misc]+=" ${(j:/:)gitstatus}"
}

# Report the existence of an unstaged file.
function has_unstaged_files() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -E '\bM' &> /dev/null; then
        echo '%F{5}'
    else
        echo '%F{6}'
    fi
}

setopt prompt_subst
prompt='%1~ $(has_unstaged_files)${vcs_info_msg_0_}%f> '
#prompt='${vcs_info_msg_0_}  ────  '
#RPROMPT='${vcs_info_msg_0_}'
