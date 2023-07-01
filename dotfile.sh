#!/bin/bash

# rustup
rustup component add rust-analyzer

# brew
brew install tmux
brew install fzf
brew install ripgrep
brew install bat
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font

# dotfile
cp .bashrc ~/
cp .vimrc ~/
cp .tmux.conf ~/
cp .gitconfig ~/
cp .gitignore_global ~/

