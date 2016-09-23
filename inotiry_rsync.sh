#!/bin/bash

#
# backup script using inotify and rsync
# hongjin.cao
#

#
# variables
#

LOG_FILE=/home/wiki/backup-log/`date +'%Y-%m-%d'`.log
WIKI_ROOT=/var/www/html/
BACKUP_MACHINE_PATH=/home/manager/wiki-backup                             
BACKUP_MACHINE_IP=10.0.0.1 
BACKUP_MACHINE_USER=manager
INOTIFYWAIT_BIN=`which inotifywait`

#
# function util
#
function LOG()
{
	echo "$@">>$LOG_FILE
}


#
# start
#

LOG "==========================================="
LOG " Backup Start at:" `date +%H:%M:%S`
LOG "==========================================="

cd $WIKI_ROOT || { LOG 'WIKI_ROOT ERROR' && exit; }
$INOTIFYWAIT_BIN -mrq --excludei='(data/cache/|data/locks/|data/index/|data/tmp/)' --format  '%e %w%f %T' --timefmt='%Y-%m-%d/%H:%M:%S' -e modify,create,delete,attrib,close_write,move .  | \
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
