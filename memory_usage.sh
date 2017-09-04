#!/bin/bash

set -x

WHO=server
MEM_LOG=memory_usage_$WHO.log

function use_free()
{
while true;
do
	free | grep -v "total" | awk  \
	'
	BEGIN {

	}

	{
		if(NR==1) memory=$3 
			if(NR==2) swap=$3 
	}  

	END { 
		print "total memory:", memory, "swap:", swap 
	} 
	' >>$MEM_LOG
	sleep 10
done
}

function use_py()
{
    ./ps_mem.py -w 10 --swap --total -p $(pgrep $WHO) >>$MEM_LOG &
}

use_py
