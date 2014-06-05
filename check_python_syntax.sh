#!/bin/bash

# 检查某个目录下python文件的语法是否正确
# 参数1: 要check的文件夹

CHECK_DIR=${1:-~/work/svn/20110830_migrate_modular}

check(){
	python -m py_compile $1
}


for py_file in `find $CHECK_DIR -name "*.py"`
do
	check $py_file
done
