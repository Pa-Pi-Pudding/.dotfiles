#!/usr/local/bin/zsh
#
PATH=/Users/kyuchida/.pyenv/shims:/Users/kyuchida/Library/Java/JavaVirtualMachines/corretto-18.0.2/Contents/Home/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Users/kyuchida/Library/Java/JavaVirtualMachines/corretto-18.0.2/Contents/Home/bin:/Users/kyuchida/.cache/dein/repos/github.com/junegunn/fzf/bin:/Users/kyuchida/Library/Java/JavaVirtualMachines/corretto-18.0.2/Contents/Home/bin

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
