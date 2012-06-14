#!/bin/sh

##
## This script is ...
##
# ���Υ�����ץȤ�Apache�Υ������ġ����rotatelogs�פˤ�äƺ������줿
# �ɥᥤ���̤�Apache���򰵽̡���������ΤǤ���
#
# ���̤�7���ʾ����������90���ʾ������ǥե���ȤǤ�����
# �����˹�碌�ƿ��ͤ��ѹ����Ƥ���������
#
# ex) sh /PATH/TO/log_delete.sh "/DELETE/LOG/PATH/"
#


##
## �������
##
# PATH
PATH=/sbin:/usr/sbin:/bin:/usr/bin
export PATH
start_date=`date`

# log����Ǽ����Ƥ���ǥ��쥯�ȥ������
if [ -n "$1" ] ;then
	log_dir=$1
else
	echo 'ex) sh /PATH/TO/log_delete.sh "/DELETE/LOG/PATH/"'
	exit 1
fi



##
## 90���ʾ����˽������줿�ե��������
##
find ${log_dir} -maxdepth 1 -type f -mtime +90 | xargs rm -rf 2>&1



##
## 7���ʾ����˽������줿�ե�����򰵽�
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