#!/bin/bash

# usage: killnginx [port] 
# port has default value 8080
# hongjin.cao (huntinux@gmail.com)
# 2014-04-12

function usage(){
	echo "Usage:$0 [port]"
	echo "port has default 8080"		
}

if [ $# -eq 1 ];then
	port=$1
else
	usage
	port=8080
fi
#port=${1:-8080}

nginxpid=`netstat -lpnt 2>/dev/null | grep $port | awk -F'/' '{print $(NF-1)}' | awk '{print $(NF)}'`
if [ "$nginxpid" == "" ]; then
	echo "nginx using port:[$port] does not exist."
else
	echo "nginx port:[$port] pid:[$nginxpid]"
fi

#[ "$nginxpid" == "" ] && 
#	echo "nginx using port:[$port] does not exist." ||
#	echo "nginx port:[$port] pid:[$nginxpid]"

exit 0
