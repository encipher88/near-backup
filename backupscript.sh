#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M)
DATADIR="/root/.near/data/"
BACKUPDIR=/root/.near/backups/near_${DATE}

mkdir $BACKUPDIR

sudo systemctl stop neard

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUPDIR" ]; then
    echo "Backup started" | ts
    tar -czf root/backups/mydata-${DATE}.tgz $DATADIR
    echo "Backup completed" | ts
    find root/backups/mydata-* -mtime +3 -exec rm {} \;
    echo "export DATENEW=$DATE" >> $HOME/.bash_profile
    source $HOME/.bash_profile
    
else
    echo $BACKUPDIR is not created. Check your permissions.
    exit 0
fi

sudo systemctl start neard

echo "NEAR node was started" | ts

