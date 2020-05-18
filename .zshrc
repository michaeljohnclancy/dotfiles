# Add local bin directory to path
export PATH=$HOME/.local/bin:$PATH

##### XDG DIRECTORY SETTINGS #####

# XDG CONFIG
export XDG_CONFIG_HOME="$HOME"/.config
export XMONAD_CONFIG_HOME="$XDG_CONFIG_HOME"/xmonad
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

alias xbindkeys="xbindkeys -f $XDG_CONFIG_HOME/xbindkeys/config"
alias nvidia-settings="nvidia-settings --config=$XDG_CONFIG_HOME/nvidia/settings"

# XDG DATA
export XDG_DATA_HOME="$HOME"/.local/share
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export XMONAD_DATA_HOME="$XDG_DATA_HOME"/xmonad

# XDG CACHE
export XDG_CACHE_HOME="$HOME"/.cache
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export XMONAD_CACHE_HOME="$XDG_CACHE_HOME"/xmonad

###################################
