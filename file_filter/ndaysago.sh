#!/bin/bash

#
# remove file N days ago
# Usage: 
#

#set -x # open debug

if [ $# != 3 ]; then
    echo "Usage: $0 directory days depth"
    exit
fi

#DIR_PATH=${1:-.}
#DAYS_BEFOR=${2:--7} 
#DIR_DEPTH=${3:-1}

DIR_PATH=$1
DAYS_BEFOR=$2 
DIR_DEPTH=$3

echo "Usage: $0 directory depth days"
echo 
echo "Arguments:"
echo "DIRECTORY:        \"$DIR_PATH\""
echo "DIRECTORY DEPTH:  $DIR_DEPTH"
echo "TIME:             $DAYS_BEFOR(day)"
echo 
echo "Matching Files:"

# only show the file's path
find $DIR_PATH -maxdepth $DIR_DEPTH -type f -a -mtime $DAYS_BEFOR -exec file '{}' \;

# delete the files
#find $DIR_PATH -maxdepth $DIR_DEPTH -type f -a -mtime $DAYS_BEFOR -exec rm '{}' \; -print 
