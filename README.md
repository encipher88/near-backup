# near-backup

sudo nano /etc/crontab
0  12 *  *  * near      root/.near/backup.sh >>  root/.near/backups/backup.log 2>&1
