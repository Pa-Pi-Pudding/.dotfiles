#!/usr/local/bin/zsh
#

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# zprof start
# zmodload zsh/zprof && zprof

# OS Type
case ${OSTYPE} in
    darwin*)
        [[ -f ~/.zshrc.osx ]] && source ~/.dotfiles/.zshrc.osx
        ;;
    linux-gnu*)
        [[ -f ~/.zshrc.linux ]] && source ~/.dotfiles/.zshrc.linux
        ;;
esac

# load settings
# source ~/.zsh/.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/keybind.zsh
source ~/.zsh/completion.zsh

# Python
# Init pyenv
if [ -e ~/.pyenv ]; then
    eval "$(pyenv init -)"
    if type aws > /dev/null 2>&1; then
        source "$(pyenv which aws_zsh_completer.sh)"
    fi
fi

# Init pyenv-virtualenv
if [ -e ~/.pyenv/plugins/virtualenv ]; then
    eval "$(pyenv virtualenv-init -)"
fi

# Init anyenv
if [ -e ~/.anyenv ]; then
    eval "$(anyenv init -)"
fi

#eval $(ssh-agent) > /dev/null
#ssh-add ~/.ssh/id_rsa > /dev/null 2>&1

# zprof end
if (which zprof > /dev/null 2>&1) ;then
  zprof
fi

if [ -f ~/.fzf.zsh ]; then
    source ~/.zsh/fzf.zsh
fi
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export LESSCHARSET=utf-8

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
