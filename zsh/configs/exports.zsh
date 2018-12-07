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

# polybar
export POLYBAR_ETH_INTERFACE="$($(ip a | grep "[1-9]: enp" | head -n 1 | awk '{print $2}'): : -1)"
