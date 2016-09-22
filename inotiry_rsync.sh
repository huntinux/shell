#!/bin/bash

#
# backup script using inotify and rsync
# hongjin.cao
#

#
# variables
#
LOG_FILE=/dev/null
WIKI_ROOT=/home/wiki/work/wiki/
BACKUP_MACHINE_PATH=/home/wiki/work/wiki-backup/
BACKUP_MACHINE_IP=10.0.0.1
BACKUP_MACHINE_USER=hongjin.cao
INOTIFYWAIT_BIN=`which inotifywait`

#
# start
#

cd ${WIKI_ROOT}                         
$INOTIFYWAIT_BIN -mrq --excludei='(data/cache/|data/locks/)' --format  '%e %w%f' -e modify,create,delete,attrib,close_write,move . | \
while read INO_EVENT INO_FILE
do
       echo "Event:$INO_EVENT File:$INO_FILE"

       if [[ $INO_EVENT =~ 'CREATE' ]] || [[ $INO_EVENT =~ 'MODIFY' ]] || [[ $INO_EVENT =~ 'CLOSE_WRITE' ]] || [[ $INO_EVENT =~ 'MOVED_TO' ]]         
       then
                rsync -avzc  ${INO_FILE} ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}          
        fi

        if [[ $INO_EVENT =~ 'DELETE' ]] || [[ $INO_EVENT =~ 'MOVED_FROM' ]]
        then
                rsync -avz --ignore-existing --recursive --delete  $(dirname ${INO_FILE}) ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH} 
        fi

        if [[ $INO_EVENT =~ 'ATTRIB' ]]
        then
                if [ ! -d "$INO_FILE" ] 
                then
                        rsync -avzcR $(dirname ${INO_FILE}) ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}
                fi
        fi
done
