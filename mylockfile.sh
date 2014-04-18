#!/bin/sh

#
# 以非阻塞的方式带开文件
# 测试方法：在一个终端 sh mylockfile.sh 占用文件。
# 在另一个终端 sh mylockfile.sh 的时候因为上一个
# 终端中的进程已经以非阻塞方式占用了此文件，所以
# 当前进程调用flock时，不会阻塞，会立即返回。
#

set -x

exec 6<>"mylockfile.sh" # 以读写方式打开文件mylockfile.sh，文件描述符为6

{
    flock -n 6 # 以非阻塞方式打开文件描述符为6的文件

    #[ "$?" -eq "1" ] && {echo "fail";exit;}
    if [ "$?" -eq "1" ] ; then
        echo "fail";
        exit;
    fi
    echo $$

    sleep 10
}
#} 6<>"mylockfile.sh" 
