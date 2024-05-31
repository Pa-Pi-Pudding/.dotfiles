#!/bin/bash

# Tap repositorys
# brew tap universal-ctags/universal-ctags
brew tap motemen/ghq

# Install commands
# https://github.com/Fendo181/dotfile/issues/2
# 古いzshを新しいzshにする。zshの向き先を変更する
brew install zsh 
sudo chsh -s `command -v zsh` $USER
brew install pt
brew install ghq
brew install go
brew install tree
brew install neovim
# brew install global --with-exuberant-ctags --with-pygments
# brew install universal-ctags
