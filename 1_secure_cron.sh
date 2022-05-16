#!/bin/bash

exec > ./1_secure_cron.log 2>&1

echo "##################################"
echo "#   Step 1: Secure Cron - START  #"
echo "##################################"

echo "#Step 1: Secure Cron --> MSG: secure /etc/crontab"
chown root:root /etc/crontab
chmod og-rwx /etc/crontab

echo "#Step 1: Secure Cron --> MSG: Secure /etc/cron.hourly"
chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly

echo "#Step 1: Secure Cron --> MSG: Secure /etc/cron.daily"
chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily

echo "#Step 1: Secure Cron --> MSG: Secure /etc/cron.monthly"
chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly

echo "#Step 1: Secure Cron --> MSG: Secure /etc/cron.d"
chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d

echo "#Step 1: Secure Cron --> MSG: Restrict CRON access"
touch /etc/cron.allow
touch /etc/cron.deny
chmod og-rwx /etc/cron.allow
chmod og-rwx /etc/cron.deny


echo "#Step 1: Secure Cron --> MSG: Verify result"
ls -l /etc/crontab
ls -l /etc/cron.hourly
ls -l /etc/cron.daily
ls -l /etc/cron.monthly
ls -l /etc/cron.d
ls -l /etc/cron.allow
ls -l /etc/cron.deny


echo "################################"
echo "#   Step 1: Secure Cron - END  #"
echo "################################"
 






