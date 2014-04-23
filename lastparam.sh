#!/bin/bash

#
# 得到最后一个位置参数
# 来自：abs chp4 http://www.tldp.org/LDP/abs/html/othertypesv.html
#

# 测试方法： ./lastparam.sh 1 2 3 4
# 会输出最后一个参数4

argnum=$#
echo "argnum=$argnum"

lastparam=${!argnum} # !表示间接引用 参考： http://www.tldp.org/LDP/abs/html/bashver2.html#VARREFNEW
#lastparam=${!#} # 另一种方法
echo "lastparam is $lastparam"


exit 0
