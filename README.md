```
sudo apt install moreutils zip
cd scripts
sudo tee /home/encipher/scripts/backup.sh > /dev/null <<EOF
#!/bin/bash
DATE=$(date +%Y-%m-%d)
DATADIR=/home/encipher/.near
BACKUPS_DIR=/home/encipher/backups
BACKUP_DATA=${BACKUPS_DIR}/near_${DATE}
SERVICE_NEAR_NAME=neard.service

TELEGRAM_BOT_TOKEN="YOUR TELEGRAM BOT TOKEN"
CHAT_ID="YOUR CHAT ID"
TG_URL=https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage
NEW_BACKUP_FILE=$BACKUP_DATA.zip

if [ ! -d "$BACKUPS_DIR" ]; then
  echo "Create directory $BACKUPS_DIR" | ts
  mkdir $BACKUPS_DIR
fi

OLD_BACKUPS=`ls $BACKUPS_DIR/*.zip`
for file in $OLD_BACKUPS
  do
     rm $file
     if [ ! -d "$file" ]; then
       echo "$file has been deleted" | ts
     fi
  done

sudo systemctl stop $SERVICE_NEAR_NAME
wait

echo "New backup started" | ts
zip -r $BACKUP_DATA $DATADIR
echo "Backup completed" | ts
sudo systemctl start $SERVICE_NEAR_NAME


if [ -f $NEW_BACKUP_FILE ]; then
   curl -s -X POST $TG_URL -d chat_id=$CHAT_ID -d parse_mode=markdown \
         -d text="Backup success. New File: $NEW_BACKUP_FILE "
else
   curl -s -X POST $TG_URL -d chat_id=$CHAT_ID -d text="Not created!"
fi
EOF
chmod +x backup.sh
sudo ./scripts/backup.sh
```
