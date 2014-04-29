#!/bin/bash

# 
# 输出系统上的所有用户
#

USER_FILE="/etc/passwd"

row=0
for name in $(awk 'BEGIN{FS=":"} {print $1}' <$USER_FILE)
do
	let row++
	echo "User$row:	$name"
done

