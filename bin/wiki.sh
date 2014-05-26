#!/bin/bash

#
# 生成每日wiki框架
#

(
cat <<!EOF! 
h2. `date +%F `

* finished
#

* todo
#
!EOF!
) | xclip
