export XDG_BIN_HOME=$HOME/.local/bin

# Add local bin directory to path
export PATH=$XDG_BIN_HOME:$PATH

# Sets the standard envvars for default editor.
export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"

##### XDG DIRECTORY SETTINGS #####
# ENVARS defined here, aliases defined in .zshrc

# XDG CONFIG
export XDG_CONFIG_HOME="$HOME"/.config
export XMONAD_CONFIG_HOME="$XDG_CONFIG_HOME"/xmonad
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

# XDG DATA
export XDG_DATA_HOME="$HOME"/.local/share
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export XMONAD_DATA_HOME="$XDG_DATA_HOME"/xmonad
export ZSH="$XDG_DATA_HOME"/zsh/oh_my_zsh
export STACK_ROOT="$XDG_DATA_HOME"/stack
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export WORKON_HOME="$XDG_DATA_HOME"/virtualenvs
export HIE_HOOGLE_DATABASE="$XDG_DATA_HOME"/hoogle/default-haskell.hoo

# XDG CACHE
export XDG_CACHE_HOME="$HOME"/.cache
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export XMONAD_CACHE_HOME="$XDG_CACHE_HOME"/xmonad
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION" # Sets the location of the Oh-My-Zsh autocompletion cache.

##################################

