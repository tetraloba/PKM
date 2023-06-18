#!/bin/bash
# Ver.0.4.0
fileExt='.td' # 結構使うし、変更の可能性もあるので一応変数化。置換でも良さげだけど。
DATADIR=~/projects/PKM/ # 文字列にしてはならない(戒め)
DATADIR=${DIR}data/
userName='tetraloba' # 権限設定時のユーザ名
if [ $# -eq 0 -o "$1" = "mk" ]; then # mk(make)コマンド
  DATE=`date "+%Y/%m/%d %H:%M:%S"` # 現在時刻を取得
  fileName=`date "+%y%m%d%H%M%S" -d "$DATE"` # ファイル名を生成
  FILEDIR=${DATADIR}${fileName}${fileExt} # diaryファイルを生成するディレクトリを指定
  echo -e "\\\title: \n\\\date: $DATE\n\\\tags: \n\\\main:" > $FILEDIR # ファイルの生成とテンプレートの入力
  code -g $FILEDIR:1:9 # codeでtitleにカーソルを合わせて開く
  exit 0;

elif [ "$1" = "ls" ]; then # ls(list)コマンド tdファイル一覧をタイトル付きで表示する。
  IFS_ORG=$IFS # IFS(区切り文字)変数のオリジナルを退避
  IFS=$'\n' # IFS変数を改行のみに変更
  arr_string=$(grep -r -A2 "^\\\title:" ${DATADIR}*${fileExt}) # grepの検索結果を配列に代入(改行区切り)
  for str in ${arr_string[@]}; do
    echo ${str#$DATADIR} # ディレクトリ部分を取り除いて出力
  done
  IFS=$IFS_ORG # IFS変数を復元
  exit 0;

elif [ "$1" = "find" ]; then # findコマンド
  if [ $# -lt 2 ]; then
    echo "find: too few argument";
    exit 0;
  fi
  IFS_ORG=$IFS # IFS(区切り文字)変数のオリジナルを退避
  IFS=$'\n' # IFS変数を改行のみに変更
  arr_files=$(grep -lr $2 ${DATADIR}*${fileExt}) # grepの検索結果(ファイル名)を配列に代入(改行区切り)
  for file_finded in ${arr_files[@]}; do
    echo "-----${file_finded##*/}-----"; # ##*/ -> #$DATADIR も可
    echo "$(grep -A1 "^\\\title:" ${file_finded})";
    # grep -n --color=auto $2 ${file_finded};
    arr_string=$(grep -n --color=always $2 ${file_finded}) # grepの検索結果を配列に代入(改行区切り)(色付き)
    for str in ${arr_string[@]}; do
      echo "  ${str}";
    done
  done
  IFS=$IFS_ORG # IFS変数を復元
  exit 0;

elif [ "$1" = "install" ]; then # installコマンド
  sudo chmod 744 ${DIR}$(basename $0)
  sudo chown ${userName} ${DIR}$(basename $0)
  sudo rm /usr/local/bin/$(basename ${0%.*})
  sudo ln -s ${DIR}$(basename $0) /usr/local/bin/$(basename ${0%.*})
  exit 0;

else # 存在しないコマンド
  echo "command '${1}' not found"
fi
