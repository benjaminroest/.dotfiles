# Load and initialise completion system
autoload -Uz compinit
compinit

bindkey -M menuselect '^[[Z' reverse-menu-complete
