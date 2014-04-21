#!/bin/bash

#
# 读取文件所在路径
#

# 显示执行的命令，并显示执行结果
execuate(){
	echo "------------------------"
	echo "\$ $@"
	"$@"
	echo 
}

#DIRNAME_RESULT=$(dirname $0)
#echo "dirname:$DIRNAME_RESULT"
execuate dirname $0

#REAL_PATH1=$(dirname $(readlink -f $0))
#echo "full path:$REAL_PATH1"
execuate dirname $(readlink -f $0)

		
