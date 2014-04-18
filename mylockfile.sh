#!/bin/sh

# 以非阻塞的方式带开文件6

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
