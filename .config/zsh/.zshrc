
#XDG aliases
alias xbindkeys="xbindkeys -f $XDG_CONFIG_HOME/xbindkeys/config"
alias nvidia-settings="nvidia-settings --config=$XDG_CONFIG_HOME/nvidia/settings"

###################################
############ ZSH CONFIG ###########

ZSH_THEME=xiong-chiamiov-plus # Sets zsh theme.
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main brackets) # Adds highlighting when parentheses aren't matched.

DISABLE_AUTO_UPDATE="true"   # Disable autoupdate.
export CASE_SENSITIVE="true" # Makes autocomplete case sensitive.

HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000
SAVEHIST=1000

setopt autocd                # cd by typing in directory name.
setopt nomatch               # Warn if glob doesn't match.
setopt no_case_glob          # Globbing case-insensitive.
setopt interactive_comments  # Commands predeeded with # aren't run.
setopt menu_complete         # Cycle through completions like Vim.
export MENU_COMPLETE=1
setopt hist_ignore_space     # Do not record commands to history if prepended with a space.

ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&' # Don't strip space between | char and EOL.

# Make ^H and backspace behave correctly
bindkey "^H" backward-delete-char

bindkey -v # Turn on Vim keybindings.

vi-search-fix() { # Fix for ESC + / not working properly sometimes.
  zle vi-cmd-mode
  zle .vi-history-search-backward
}
autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix

# history search with j/k in vi normal mode
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward

# ZSH Styling
zstyle :compinstall filename $HOME/.zshrc

zstyle ':completion:*:*:*:*:*' menu ''                    # Emulates Vim menu completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={a-zA-Z}' # Combats Oh-My-Zsh fuzzy tab completion.
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"  # Tab completed files have same color as used for ls --color.
zstyle ':completion:*' verbose false                      # Turns off descriptions for tab completion entries.

# Turn on all the completion stuff
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
autoload -Uz zmv

compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION # Sets the location of the Oh-My-Zsh autocompletion cache.

