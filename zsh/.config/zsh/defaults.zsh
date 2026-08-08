# Load and initialise completion system
autoload -Uz compinit
compinit

bindkey -M menuselect '^[[Z' reverse-menu-complete

# Enable vi mode
bindkey -v

# Search substring plugin
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

path+=('/home/benjamin/scripts')

export PATH
export VUE_EDITOR=/Users/benjaminroest/Scripts/launch-editor
export LAUNCH_EDITOR=/Users/benjaminroest/Scripts/launch-editor
