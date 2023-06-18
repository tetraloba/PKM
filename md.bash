#!/bin/bash
fileExt='.td' # 結構使うし、変更の可能性もあるので一応変数化。置換でも良さげだけど。
DIR=~/Notepad/PKM/
if [ $# -eq 0 -o "$1" = "mk" ]; then # mk(make)コマンド
  DATE=`date "+%Y/%m/%d %H:%M:%S"` # 現在時刻を取得
  fileName=`date "+%y%m%d%H%M%S" -d "$DATE"` # ファイル名を生成
  DIR1=${DIR}${fileName}${fileExt} # diaryファイルを生成するディレクトリを指定
  echo -e "\\\title: \n\\\date: $DATE\n\\\tags: \n\\\main:" > $DIR1 # ファイルの生成とテンプレートの入力
  code -g $DIR1:1:9 # codeでtitleにカーソルを合わせて開く
  exit 0;
fi
if [ "$1" = "ls" ]; then # ls(list)コマンド tdファイル一覧をタイトル付きで表示する。
  IFS_ORG=$IFS # IFS(区切り文字)変数のオリジナルを退避
  IFS=$'\n' # IFS変数を改行のみに変更
  arr_string=$(grep -r -A2 "^\\\title:" ${DIR}*${fileExt}) # grepの検索結果を配列に代入(改行区切り)
  for str in ${arr_string[@]}; do
    echo ${str#$DIR} # ディレクトリ部分を取り除いて出力
  done
  IFS=$IFS_ORG # IFS変数を復元
else
  echo "command '${1}' not found"
fi




# sudo mv ./md /usr/local/bin/ でPATH通っている場所に入れて
# sudo chmod 744 /usr/local/bin/md を確認して
# sudo chown tetraloba /usr/local/bin/md を確認