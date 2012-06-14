#!/bin/sh

##
## This script is ...
##
# このスクリプトはApacheのログ管理ツール「rotatelogs」によって作成された
# ドメイン別のApacheログを圧縮、削除するものです。
#
# 圧縮は7日以上前、削除は90日以上前がデフォルトですが、
# 状況に合わせて数値を変更してください。
#
# ex) sh /PATH/TO/log_delete.sh "/DELETE/LOG/PATH/"
#


##
## 初期設定
##
# PATH
PATH=/sbin:/usr/sbin:/bin:/usr/bin
export PATH
start_date=`date`

# logが格納されているディレクトリの設定
if [ -n "$1" ] ;then
	log_dir=$1
else
	echo 'ex) sh /PATH/TO/log_delete.sh "/DELETE/LOG/PATH/"'
	exit 1
fi



##
## 90日以上前に修正されたファイルを削除
##
find ${log_dir} -maxdepth 1 -type f -mtime +90 | xargs rm -rf 2>&1



##
## 7日以上前に修正されたファイルを圧縮
##
find ${log_dir} -maxdepth 1 -type f -mtime +7 | grep -v gz | xargs gzip 2>&1


##
## end report
##
end_date=`date`
/bin/mail -s "apache log_delete end" "koshiba@netsket.com" << BODY

`echo "start = ${start_date}"`
`echo "end = ${end_date}"`

BODY


exit 0