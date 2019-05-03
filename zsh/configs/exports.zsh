# exports
export PATH="$PATH:$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin"
# export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
export LESSHISTFILE="-"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# editor
export VISUAL=nvim

# fzf
FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

# {neo}vimrc
export VIMRC="$HOME/.vimrc"
export NEOVIMRC="$HOME/.config/nvim/init.vim"

# LS_COLORS
eval `dircolors $HOME/.dotfiles/dir_colors`
