#!/bin/bash

#
# 测试google连接速度
#

test_list="
	www.google.com.hk
	www.google.ca
"
PING_NUM=10

test_speed(){
	if [ -z $1 ]; then  
		echo "\$1 is not provided"
		exit 1
	fi

	echo "============="
	echo "Now ping $url"
	ping -c $PING_NUM $1
}


#
# start
#
for url in $test_list
do
	test_speed $url
done
