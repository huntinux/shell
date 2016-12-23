#!/bin/bash

#
# backup script using inotify and rsync
# hongjin.cao
#

#
# variables
#

BACKUP_LOG_FILE=/home/huntinux/work/tmp/wiki-backup-log/`date +'%Y-%m-%d'`.log
BACKUP_ROOT=/home/huntinux/work/tmp/wiki
#BACKUP_EXCLUDE_DIRS="(data/cache/|data/locks/|data/index/|data/tmp/)"
BACKUP_MACHINE_PATH=/home/huntinux/work/tmp/wiki-backup
BACKUP_MACHINE_IP=127.0.0.1
BACKUP_MACHINE_USER=huntinux

#
# function util
#
function LOG()
{
	echo "$@">>$BACKUP_LOG_FILE
}
function CHECK_EXIST()
{
    command -v "$@" >/dev/null 2>&1 || { echo >&2 "I require '$@' but it's not installed.  Aborting."; exit 1; }
    #type "$@" >/dev/null 2>&1 || { echo >&2 "I require '$@' but it's not installed.  Aborting."; exit 1; }
    #hash "$@" 2>/dev/null || { echo >&2 "I require '$@' but it's not installed.  Aborting."; exit 1; }
}

#
# start
#

LOG "==========================================="
LOG " Backup Start at:" `date +%H:%M:%S`
LOG "==========================================="

CHECK_EXIST inotifywait
CHECK_EXIST rsync 

cd $BACKUP_ROOT || { LOG 'BACKUP_ROOT ERROR' && exit 1; }
inotifywait -mrq --excludei='$BACKUP_EXCLUDE_DIRS' --format  '%e %w%f %T' --timefmt='%Y-%m-%d/%H:%M:%S' -e modify,create,delete,attrib,close_write,move .  | \
while read INO_EVENT INO_FILE INO_TIME
do
       if [[ $INO_FILE =~ './data/meta/davcal.sqlite3' ]]; then
		# DON'T LOG davcal things
		:
       else
       		LOG "$INO_TIME Event:$INO_EVENT File:$INO_FILE"
       fi

       if [[ $INO_EVENT =~ 'CREATE' ]] || [[ $INO_EVENT =~ 'MODIFY' ]] || [[ $INO_EVENT =~ 'CLOSE_WRITE' ]] || [[ $INO_EVENT =~ 'MOVED_TO' ]]         
       then
       		#rsync -avzcR $(dirname ${INO_FILE}) ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}          
       		rsync -avzcR ${INO_FILE} ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}          
       fi

       if [[ $INO_EVENT =~ 'DELETE' ]] || [[ $INO_EVENT =~ 'MOVED_FROM' ]]
       then
               	rsync -avzR --ignore-existing --delete  $(dirname ${INO_FILE}) ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH} 
       fi

       if [[ $INO_EVENT =~ 'ATTRIB' ]]
       then
               	if [ ! -d "$INO_FILE" ] 
               	then
               		rsync -avzcR $(dirname ${INO_FILE}) ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}
               	fi
       fi
done
