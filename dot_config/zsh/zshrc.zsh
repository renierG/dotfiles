# Enable colors
autoload -U colors && colors
export TERM=xterm-256color

# Editor
export EDITOR="nvim"
alias vim="nvim"
alias vi="nvim"
bindkey -e


# History
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Imports (before compinit)
source "$HOME/.config/zsh/asdf.zsh"
source "$HOME/.config/zsh/oxidize.zsh"

# Package manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Completions (before plugins)
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Plugins
zinit light Aloxaf/fzf-tab
zinit light olets/zsh-abbr
zinit light spaceship-prompt/spaceship-prompt
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting

