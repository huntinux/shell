#!/bin/bash

#
# backup local data to remote machine in real time using inotify and rsync
#

MONITOR_DIR=/home/yourself/doc/
MONITOR_IGNORE_DIRS= # example: (data/cache/|data/locks/|data/index/|data/tmp/)'
BACKUP_LOG_LOCAL_PATH=/home/yourself/backup-log/
BACKUP_MACHINE_IP=10.0.0.1
BACKUP_MACHINE_USER=someone
BACKUP_MACHINE_PATH=/home/someone/backup

#
# function util
#
function LOG()
{
    LOG_FILE=$BACKUP_LOG_LOCAL_PATH`date +'%Y-%m-%d'`.log
	echo "$@">>$LOG_FILE
}

#
# start the real-time backup service 
#
function start() {
	
	LOG "==========================================="
	LOG "Backup Start at:" `date +%H:%M:%S`
	LOG "==========================================="
	
	cd $MONITOR_DIR || { LOG 'MONITOR_DIR ERROR' && exit 1; }
	inotifywait -mrq --excludei='$MONITOR_IGNORE_DIRS' --format '%e %w%f %T' --timefmt='%Y-%m-%d/%H:%M:%S' -e modify,create,delete,attrib,close_write,move .  | \
	while read INO_EVENT INO_FILE INO_TIME
	do
	       #echo $INO_TIME" "$INO_FILE" "$INO_EVENT
	       #if [[ $INO_FILE =~ './data/meta/davcal.sqlite3' ]]; then
	       # 	# DON'T LOG davcal things
	       # 	:
	       #else
	       #		LOG "$INO_TIME Event:$INO_EVENT File:$INO_FILE"
	       #fi
	
	
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
	
}

#
# stop the backup service
#
function stop() {
	LOG "==================================================="
	LOG "Backup stop at:" `date +%H:%M:%S`" >_< "
	LOG "==================================================="
	#sudo killall $(basename "$0")
}

#
# backup all data 
#
function oneshot() {
	LOG "==================================================="
	LOG "Backup Oneshot start at:" `date +%H:%M:%S`
	LOG "==================================================="

	cd $MONITOR_DIR || { LOG 'MONITOR_DIR ERROR' && exit 1; }
	rsync -avzcR ./ ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}          

	LOG "======================================================"
	LOG "Backup Oneshot Finished at:" `date +%H:%M:%S`
	LOG "======================================================"
}

#
# main
#
if [ ! $# -eq 1 ]; then
	echo "Usage: $0 [start|stop|oneshot]"
	exit 1;
fi

case $1 in
  start|stop|oneshot) "$1" ;;
  *) echo "Unkonwn param: $1"
     echo "Usage: $0 [start|stop|oneshot]"
esac
