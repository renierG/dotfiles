#!/bin/bash
set -e

# exit early if not running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
  exit 0
fi

echo "[INFO] Run macOS setup..."

if ! xcode-select -p &>/dev/null; then
  echo "[INFO] Xcode Command Line Tools not found. Installing..."
  xcode-select --install
fi

if ! which brew &>/dev/null; then
  echo "[INFO] Install brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "[INFO] Update brew..."
brew update

brew_install() { [[ "$1" == "--cask" ]] && shift && (brew list --cask "$1" &>/dev/null && echo " - $1" || (echo " - $1" && brew install --cask "$1")) || (brew list --formula "$1" &>/dev/null && echo " - $1" || (echo " - $1" && brew install "$1")); }

echo "[INFO] Install brew packages..."
brew_install bat # oxidized cat
brew_install coreutils
brew_install eza # oxidized ls
brew_install findutils
brew_install fzf
brew_install gawk
brew_install gh
brew_install git
brew_install gnu-getopt
brew_install gnu-indent
brew_install gnu-sed
brew_install gnu-tar
brew_install gnutls
brew_install grep
brew_install htop
brew_install jq
brew_install kubectl
brew_install neofetch
brew_install neovim
brew_install npm
brew_install oh-my-posh
brew_install podman
brew_install podman-compose
brew_install tree
brew_install wget
brew_install yq
brew_install zsh

brew install awscli
brew install azure-cli
brew install helm
brew install kubernetes-cli
# brew install gcloud

brew_install --cask font-jetbrains-mono-nerd-font
brew_install --cask ghostty
brew_install --cask jetbrains-toolbox
brew_install --cask nikitabobko/tap/aerospace
brew_install --cask raycast
brew_install --cask shottr
brew_install --cask zed

echo "[INFO] Cleanup brew..."
brew cleanup

if [[ "$SHELL" != *"zsh" ]]; then
  echo "[INFO] Change default shell to zsh"
  chsh -s /bin/zsh
fi

echo "[INFO] Set user preferences..."
defaults write -g InitialKeyRepeat -float 15.0
defaults write -g KeyRepeat -float 2.0

defaults write com.apple.dock autohide -bool true && killall Dock
