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

if [ $? -eq 0 ] 
then
	echo "Now the wiki's body is in your system clipboard. Past it with Ctrl+V"
fi

# Install xclip:
# sudo apt-get install xclip


