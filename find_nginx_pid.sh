#!/bin/bash

# usage: killnginx [port] 
# port has default value 8080
# hongjin.cao (huntinux@gmail.com)
# 2014-04-18

function usage(){
	echo "Usage:$0 [port]"
	echo "port has default 8080"		
}

function get_confirm(){
	read ans
	case $ans in 
		'y')
			return 0;;
		'n')
			return 1;;
		*)
			return 1;;
	esac
}

function killit(){
	echo -n "kill it?(y/n)"
	get_confirm && {
		sudo kill $nginxpid
		if [ $? -eq 0 ];then	
			echo "kill successfully."
		else
			echo "kill faild."
		fi
	}
}

if [ $# -eq 1 ];then
	port=$1
else
	usage
	port=8080
fi

nginxpid=`netstat -lpnt 2>/dev/null | grep $port | awk -F'/' '{print $(NF-1)}' | awk '{print $(NF)}'`
if [ "$nginxpid" == "" ]; then
	echo "nginx using port:[$port] does not exist."
else
	echo "nginx port:[$port] pid:[$nginxpid]"
	killit
fi

exit 0
