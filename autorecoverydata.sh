#!/bin/bash

DATADIR="/root/.near/data/"
BACKUPDIR=/root/.near/backups/near_${DATE}

mkdir $BACKUPDIR

sudo systemctl stop neard

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUPDIR" ]; then
rm -r $DATADIR
    echo "Backup started" | ts
    tar -xzf root/backups/mydata-${DATENEW}.tgz $DATADIR
    echo "Backup completed" | ts
else
    echo $BACKUPDIR is not created. Check your permissions.
    exit 0
fi

sudo systemctl start neard

echo "NEAR node was started" | ts
