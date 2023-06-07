#!/bin/bash

# rustup
rustup component add rust-analyzer

# brew
brew install fzf
brew install ripgrep

# dotfile
cp .bashrc ~/
cp .vimrc ~/
cp .tmux.conf ~/
cp .gitconfig ~/
cp .gitignore_global ~/

