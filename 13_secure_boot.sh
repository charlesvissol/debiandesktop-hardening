#!/bin/bash

exec > ./13_secure_boot.log 2>&1

echo "##################################"
echo "#   Step 1: Secure Boot - START  #"
echo "##################################"

echo "#Step 13: Secure Boot --> MSG: secure /boot/grub/grub.cfg"
chmod 600 /boot/grub/grub.cfg


stat /boot/grub/grub.cfg



echo "################################"
echo "#   Step 1: Secure Cron - END  #"
echo "################################"
 






