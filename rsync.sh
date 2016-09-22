#!/bin/bash

#
# backup all things
# hongjin.cao
#

#
# variables
#

WIKI_ROOT=/var/www/html/                       
BACKUP_MACHINE_PATH=/home/manager/wiki-backup                             
BACKUP_MACHINE_IP=10.0.0.1 
BACKUP_MACHINE_USER=manager

#
# start
#

rsync -avzcR $WIKI_ROOT ${BACKUP_MACHINE_USER}@${BACKUP_MACHINE_IP}:${BACKUP_MACHINE_PATH}
