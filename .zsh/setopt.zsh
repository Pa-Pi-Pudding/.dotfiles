# couplete in cousor position
setopt complete_in_word
# no blob expand when complete
setopt glob_complete
# expand history when complete
setopt hist_expand
# beep sound off
setopt no_beep
# complete sort numeric
setopt numeric_glob_sort
# Auto change direcotry when directory name only in input command
setopt auto_cd
# Saving cd history
setopt auto_pushd
# Teach error of command
setopt correct
# Compact list of complate result
setopt list_packed
# Beep sound off
setopt nolistbeep
# cd したら自動的にpushdする
setopt auto_pushd
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# Share history
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_no_store
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob
