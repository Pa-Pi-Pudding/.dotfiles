autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
autoload -Uz colors; colors
autoload -Uz add-zsh-hook
autoload -Uz terminfo

setopt prompt_subst
setopt re_match_pcre

# function current-git-branch() {
#     echo -n "$(git rev-parse --abbrev-ref=loose HEAD 2> /dev/null)"
# }

# ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # gitで管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全てcommitされてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # gitに管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git addされていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commitされていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合は青色で表示させる
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}

# プロンプトの右側(RPROMPT)にメソッドの結果を表示させる
# RPROMPT='`rprompt-git-current-branch`'

# function python-version() {
#     pv="PV:$(pyenv version-name) "
#     vv=""
#     if [ -n "$VIRTUAL_ENV" ]; then
#         vv="VV:$(basename ${VIRTUAL_ENV})"
#     fi
#     echo "${pv}${vv}"
# }

terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
left_down_prompt_preexec() {
    print -rn -- $terminfo[el]
}
add-zsh-hook preexec left_down_prompt_preexec

function zle-keymap-select zle-line-init zle-line-finish
{
    case $KEYMAP in
        vicmd)
            vimmode="$fg[white]-- NORMAL --$reset_color"
            ;;
        main|viins)
            vimmode="$fg[blue]-- INSERT --$reset_color"
            ;;
        vivis)
            vimmode="$fg[green]-- VISUAL --$reset_color"
            ;;
    esac

    local p_user="[%F{yellow}%n%f]"
    local p_cdr="%F{cyan}%~%f"
    local p_vimjob="%F{green}$([[ $(jobs|grep -c vim) != 0 ]] && print "vim:$(jobs|grep -c vim)")%f"
    local p_tigjob="%F{green}$([[ $(jobs|grep -c tig) != 0 ]] && print "tigvim:$(jobs|grep -c tig)")%f"
    #local p_branch="{%F{magenta}$(current-git-branch)%f}"
    local p_branch="$(rprompt-git-current-branch)%f}"
    local p_mark="%B%(?,%F{green},%F{red})%(!,#,>)%f%b"
    # local p_pversion="%F{red}$(python-version)%f"
    # PROMPT="%{$terminfo_down_sc${vimmode} | ${p_cdr}  $terminfo[rc]%}${p_user}${p_branch}(${p_vimjob}${p_tigjob}) ${p_mark} "
    PROMPT="%{$terminfo_down_sc${p_cdr}  $terminfo[rc]%}${p_user}${p_branch}(${p_vimjob}${p_tigjob}) ${p_mark} "


    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line
