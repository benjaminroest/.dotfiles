# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.cargo/bin:$PATH

# Path to oh-my-zsh installation.
export ZSH="/home/benjamin/.oh-my-zsh"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=powerlevel10k/powerlevel10k

plugins=(
	git
	zsh-autosuggestions
	fast-syntax-highlighting
)

my_zshdir=~/.config/shell/zsh

source $ZSH/oh-my-zsh.sh
source $my_zshdir/functions.sh

alias vim="nvim"
alias v="nvim"
alias cdg="cd \$(\ls | fzf)"
alias ls="exa --icons"
alias ll="exa -l --icons"

alias tdss5="ssh -t dss@172.16.71.125 '/home/dss/taildss2.sh'"
alias tdssprod="ssh -t root@178.162.140.165 -p 2222 'su -c /home/dss/taildss2.sh dss'"

function changeDir {
	fzf_change_dir
}
zle -N changeDir

bindkey "^Z" changeDir
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
