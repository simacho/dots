
#
# Set ALIAS
#
alias st='cygstart.exe'
alias ffx='firefox.exe &'
alias cdtrunk='cd /cygdrive/c/develop/repo/'
alias cdscrpt='cd /cygdrive/c/develop/repo/pzl00/Assets/scripts'
alias cdrsc='cd /cygdrive/c/develop/repo/pzl00/Assets/Resources'
alias cdtool='cd /cygdrive/c/develop/repo/tool'


#
# Set Functions
# 
function open-files-with-percol
#   # コマンドラインに percol で選択した文字列を代入して、結果はログに保存
#   set sep '============================================================='
#   set updir '../'
#   set res (cat <(echo $updir) <(ls) <(echo $sep) <(cat ~/.logpercol) | percol --match-method migemo)
#   set resfull (cygpath -a $res)
#   cat <(echo $resfull) ~/.logpercol | sort | uniq > ~/.logpercol
#   # フォルダならおりる
#   if [ -d $res ]; then
#    echo "to $res"
#    cd $res
#    zle reset-prompt
#   else
#   # ファイルならば履歴に追加
#    BUFFER="$BUFFER$res"
#    # カーソルの位置をコマンドラインの末尾に移動
#    CURSOR=$#BUFFER
#   fi
#   # percol による出力をクリアする
#   zle clear-screen
#
  commandline -a (ls | percol --match-method migemo)
  commandline -f repaint
    
end

# Set Key Binding
function fish_user_key_bindings
  bind \cj open-files-with-percol
end

# 初回シェル時のみ tmux実行
if test $SHLVL -eq 1
  tmux
end

