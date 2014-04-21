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


# 方法1： 使用readlink
# readlink 跟随连接，能根据链接找到真正的文件
#REAL_PATH1=$(dirname $(readlink -f $0))
#echo "full path:$REAL_PATH1"
execuate dirname $(readlink -f $0)

# 方法2： 使用cd，pwd, 得到当前文件路径，而不跟随链接
#FULL_PATH=$(cd $(dirname $0);pwd)
#echo \$FULL_PATH is $FULL_PATH
execuate cd $(dirname $0) 
execuate pwd
