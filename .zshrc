
# ==================== p10k ==================== #
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ==================== zinit ==================== #
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
	command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
	command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
		print -P "Installation successful." || \
		print -P "The clone has failed."
fi
source "$HOME/.zinit/bin/zinit.zsh"

zinit wait lucid for \
	ulwlu/enhancd \
    olets/zsh-abbr \
	zsh-users/zsh-completions \
	zsh-users/zsh-autosuggestions \
	zsh-users/zsh-syntax-highlighting \
	as'completion' is-snippet 'https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker' \
	as'completion' is-snippet 'https://github.com/docker/machine/blob/master/contrib/completion/zsh/_docker-machine' \
	as'completion' is-snippet 'https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose'


# ==================== env ==================== #
export EDITOR='nvim'
export GIT_EDITOR='$EDITOR'
export ENHANCD_FILTER=fzf
export TERM=xterm-256color
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'


# ==================== keybindings ==================== #
bindkey '^F' forward-word
bindkey '^B' backward-word


# ==================== options ==================== #
setopt no_beep
setopt globdots
setopt mark_dirs
setopt list_packed
setopt no_flow_control
setopt auto_param_keys
autoload -Uz colors && colors
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search


# ==================== completion ==================== #
setopt auto_list
setopt auto_menu
setopt share_history
setopt auto_param_slash
setopt magic_equal_subst
export HISTSIZE=100
export SAVEHIST=10000
export HISTFILE=${HOME}/.zsh_history
export FPATH="${HOME}/.zinit/completions:${FPATH}"

function run_compinit() {
  # references:
  # https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh#L31-L44
  # http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Use-of-compinit
  # https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
  # https://htr3n.github.io/2018/07/faster-zsh/

  # run compinit in a smarter, faster way
  setopt localoptions extendedglob
  ZSH_COMPDUMP=${ZSH_COMPDUMP:-${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump}
  autoload -Uz compinit
  # Glob magic explained:
  #   #q expands globs in conditional expressions
  #   N - sets null_glob option (no error on 0 results)
  #   mh-20 - modified less than 20 hours ago
  if [[ $ZSH_COMPDUMP(#qNmh-20) ]]; then
    # -C (skip function check) implies -i (skip security check).
    compinit -C -d "$ZSH_COMPDUMP"
  else
    mkdir -p "$ZSH_COMPDUMP:h"
    compinit -i -d "$ZSH_COMPDUMP"
  fi

  # Compile zcompdump, if modified, in background to increase startup speed.
  {
    if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
      zcompile "$ZSH_COMPDUMP"
    fi
  } &!
}
run_compinit

zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:default' list-colors ${LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'


# ==================== alias ==================== #
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias cdh='cd ~'

alias ll='ls -lah'
alias tr2='tree -L 2'
alias tr3='tree -L 3'
alias tr4='tree -L 4'

#alias ll='exa -alhF --group-directories-first --time-style=long-iso'
#alias llx='ll --git-ignore --ignore-glob=".git|node_modules"' tr2='llx -T -L=2' tr3='llx -T -L=3'

alias vimrc='vim ~/.vimrc'
alias ideavimrc='vim ~/.ideavimrc'
alias zshrc='vim ~/.zshrc'

alias Oni2='~/Applications/Onivim2.AppDir/AppRun'

alias gitl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"


# ==================== fzf ==================== #
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ==================== p10k ==================== #
zinit ice depth=1; zinit light romkatv/powerlevel10k
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

