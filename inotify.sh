#!/bin/bash

MONITOR_DIR=/home/huntinux/work/tmp/wiki/
BACKUP_MACHINE_IP=127.0.0.1
BACKUP_MACHINE_USER=huntinux
BACKUP_MACHINE_PATH=/home/huntinux/work/tmp/wiki-backup

cd $MONITOR_DIR || { LOG 'MONITOR_DIR ERROR' && exit 1; }
inotifywait -mrq --format '%e %w%f %T' --timefmt='%Y-%m-%d/%H:%M:%S' -e modify,create,delete,attrib,close_write,move .  | \
while read INO_EVENT INO_FILE INO_TIME
do
       echo $INO_TIME" "$INO_FILE" "$INO_EVENT
       if [[ $INO_EVENT =~ 'CREATE' ]] || [[ $INO_EVENT =~ 'MODIFY' ]] || 
          [[ $INO_EVENT =~ 'CLOSE_WRITE' ]] || [[ $INO_EVENT =~ 'MOVED_TO' ]] || 
          [[ $INO_EVENT =~ 'ATTRIB' ]]
       then
       		#rsync -avzcR $(dirname ${INO_FILE}) ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}          
       		rsync -avzcR ${INO_FILE} ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}          
       fi

       if [[ $INO_EVENT =~ 'DELETE' ]] || [[ $INO_EVENT =~ 'MOVED_FROM' ]]
       then
               	rsync -avzR --delete $(dirname ${INO_FILE}) ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH} 
       fi

       #if [[ $INO_EVENT =~ 'ATTRIB' ]]
       #then
       #        	if [ ! -d "$INO_FILE" ] 
       #        	then
       #        		rsync -avzcR $(dirname ${INO_FILE}) ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}
       #        	fi
       #fi
done
