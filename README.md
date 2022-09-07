# near-backup
```
cd .near
git clone https://github.com/encipher88/near-backup.git
sudo nano /etc/crontab
```

0  12 *  *  * root  /root/near-backup/backupscript.sh >>  root/.near/backups/backup.log 2>&1
