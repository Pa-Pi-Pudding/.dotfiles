# Default layout
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 50% --reverse --border'

# Move repository dir of ghq managenemt
function cd-fzf-ghqlist() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N cd-fzf-ghqlist
bindkey '^G' cd-fzf-ghqlist

# Checkout git branch (including remote branches)
function checkout-fzf-gitbranch() {
    local GIT_BRANCH=$(git branch --all | grep -v HEAD | fzf +m)
    if [ -n "$GIT_BRANCH" ]; then
        git checkout $(echo "$GIT_BRANCH" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    fi
    zle accept-line
}
zle -N checkout-fzf-gitbranch
bindkey '^O' checkout-fzf-gitbranch

# Set prompt command history
function buffer-fzf-history() {
    # local HISTORY=$(history -n -r 1 | fzf +m)
    # BUFFER=$HISTORY
    # if [ -n "$HISTORY" ]; then
    #     CURSOR=$#BUFFER
    # else
    #     zle accept-line
    # fi
        local tac=${commands[tac]:-"tail -r"}
    BUFFER=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sed 's/ *[0-9]* *//' | eval $tac | awk '!a[$0]++' | fzf +s)
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N buffer-fzf-history
bindkey '^R' buffer-fzf-history


# ssh selected host
function ssh-fzf-sshconfig() {
    local SSH_HOST=$(awk '
        tolower($1)=="host" {
            for (i=2; i<=NF; i++) {
                if ($i !~ "[*?]") {
                    print $i
                }
            }
        }
    ' ~/.ssh/config | sort | fzf +m)
    if [ -n "$SSH_HOST" ]; then
        BUFFER="ssh $SSH_HOST"
    fi
    zle accept-line
}
zle -N ssh-fzf-sshconfig
bindkey '^\' ssh-fzf-sshconfig
