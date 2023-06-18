#!/bin/bash
DATE=`date +%y%m%d%H%M%S` # 現在時刻を取得
DIR1=~/Notepad/PKM/$DATE.td # diaryファイルを生成するディレクトリを指定
echo -e "\\\title: \n\\\date: $DATE\n\\\tags: \n\\\main:" > $DIR1 # ファイルの生成とテンプレートの入力
code -g $DIR1:1:9 # codeでtitleにカーソルを合わせて開く
# sudo mv ./md /usr/local/bin/ でPATH通っている場所に入れて
# sudo chmod 744 /usr/local/bin/md を確認して
# sudo chown tetraloba /usr/local/bin/md を確認