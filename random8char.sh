#!/bin/bash

#
# 生成随即8位字符串
#

POS=2
LEN=8

str=${1:-$$} # str由$1指定,默认值为当前进程pid
randomstr=$(echo $str| md5sum | md5sum) # 使用md5sum 生成字符串
echo ${randomstr:$POS:$LEN} # 截取得到8位随即字符串

exit
