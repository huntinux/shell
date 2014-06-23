#!/bin/bash

#
# shell 中使用正则
#

IFS='
'
SQL='copy(select count(1) from abc) to stdout;
copy (select count(1) from address) to stdout;
#copy;'

for sql in $SQL 
do
	if [[ $sql =~ ^#.* ]]; then
		echo 'comment out'
		continue
	fi
	#psql  -h somehost -U someuser -d qunar_group -c $sql
	echo "command: $sql"
done

