#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
    # Mac
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh

    # export [ -f ~/.fzf.bash ] && source ~/.fzf.bash

elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    # Linux
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

