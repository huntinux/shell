#!/bin/sh

#
# 每次读取文件一行的内容
#

# 创建文件，并向它输入一些内容
inputfile="f.dat"
touch $inputfile
cat <<END >$inputfile
name hongjin
age 24
END

# 每次读取文件一行内容
while read line
do
	echo $line
done < $inputfile

# 分两列读取文件
while read var content
do
	echo "$var : $content"
done < $inputfile

# 删除文件
rm -f $inputfile
