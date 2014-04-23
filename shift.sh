#!/bin/bash

# 是用shift，遍历所有参数

while [ ! -z $1 ]
do
	echo $1
	shift
done

exit 0
