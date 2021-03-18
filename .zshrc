
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
	zsh-users/zsh-completions \
	zsh-users/zsh-syntax-highlighting \
	as'completion' is-snippet 'https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker' \
	as'completion' is-snippet 'https://github.com/docker/machine/blob/master/contrib/completion/zsh/_docker-machine' \
	as'completion' is-snippet 'https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose'


# ==================== env ==================== #
export EDITOR='nvim'
export GIT_EDITOR='$EDITOR'
export TERM=xterm-256color
export LS_COLORS='di=38:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export EXA_COLORS='da=38;5;245:di=38;5;14:sn=38;5;28:sb=38;5;28:uu=38;5;40:un=38;5;160:gu=38;5;40:gn=38:5:160:bl=38;5;220:ur=37:uw=37:ux=37:ue=37:gr=37:gw=37:gx=37:tr=37:tw=37:tx=37:su=37:sf=37:xa=37'


# ==================== keybindings ==================== #
bindkey '^[f^[[1;3C' forward-word
bindkey '^[b^[[1;3D' backward-word
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

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

# ==================== nnn ==================== #
n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}


# ==================== alias ==================== #
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gitl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias q='exit'

alias v='nvim' vi='nvim' vim='nvim'

alias n='n -Aeo' nnn='n -Aeo'

alias cdf='cd `fzf`'

if [ "$(uname 2> /dev/null)" != "Linux" ]; then
    alias ll='exa -alhF --group-directories-first --time-style=long-iso'
    alias llx='ll --git-ignore --ignore-glob=".git|node_modules"' tr2='llx -T -L=2' tr3='llx -T -L=3'
else
    alias ll='ls -lah'
    alias tr2='tree -L 2' tr3='tree -L 3' tr4='tree -L 4' tr5='tree -L 5'
fi

alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc'


# ==================== fzf ==================== #
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ==================== p10k ==================== #
zinit ice depth=1; zinit light romkatv/powerlevel10k
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

