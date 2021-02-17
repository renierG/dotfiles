#### Dotfile Strategy
[The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)
```
git clone --bare git@github.com:renierG/dotfiles.git $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config checkout
```

#### Tools
 - [**nvim**](https://neovim.io/): hyperextensible Vim-based text editor
 - [**exa**](https://the.exa.website/): modern replacement for _ls_.
 - [**fzf**](https://github.com/junegunn/fzf): general-purpose command-line fuzzy finder.

