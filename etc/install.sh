#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
    # Mac
    ~/.dotfiles/etc/setup/brew.sh
    ~/.dotfiles/etc/setup/kubectl.sh
    ~/.dotfiles/etc/setup/sdkman.sh
    curl -O https://raw.githubusercontent.com/Arc0re/Iceberg-iTerm2/master/iceberg.itermcolors
    iTerm >> Preferences >> Profiles >> Colors tab >> Color Presets..

elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    # Linux
    ~/.dotfiles/etc/setup/apt.sh
    ~/.dotfiles/etc/setup/kubectl.sh
    ~/.dotfiles/etc/setup/sdkman.sh
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi
