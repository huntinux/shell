#!/bin/bash

#
# 判断输入的字符类型
# 

read keypress

case "$keypress" in
	[[:lower:]] ) echo "lower char" ;;
	[[:upper:]] ) echo "upper char" ;;
	[0-9]) echo "number";;
	*) echo "other" ;;
esac

exit
