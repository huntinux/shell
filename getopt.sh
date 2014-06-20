#!/bin/bash

#
# use getopt to process command line arguments
#

while getopts n:o: opt; do
	case $opt in
		n)
			new=$OPTARG
			;;
		o)
			old=$OPTARG
	esac	
done


echo "new: $new"
echo "old: $old"

