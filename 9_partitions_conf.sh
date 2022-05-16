#!/bin/bash

exec > ./9_partitions_conf.log 2>&1

echo "###########################################"
echo "#   Step 9: Configure Partitions - START  #"
echo "###########################################"


myhost=$(cat /proc/sys/kernel/hostname)

echo "#Step 9: Configure Partitions --> MSG: backup /etc/fstab to current directory"
cp /etc/fstab ./fstab.save

echo "#Step 9: Configure Partitions --> MSG: update /boot partitions"
numline1=$(cat -n /etc/fstab | grep 'UUID' | grep '/boot           ext2' | awk '{print $1;}')
sed -i ${numline1}'s/defaults/nosuid,nodev,noexec/' /etc/fstab

echo "#Step 9: Configure Partitions --> MSG: update /home partitions"
numline2=$(cat -n /etc/fstab | grep '/dev/mapper/'${myhost}'--vg-home /home' | awk '{print $1;}')
sed -i ${numline2}'s/defaults/nodev/' /etc/fstab

echo "#Step 9: Configure Partitions --> MSG: update /tmp partitions"
numline3=$(cat -n /etc/fstab | grep '/dev/mapper/'${myhost}'--vg-tmp /tmp' | awk '{print $1;}')
sed -i ${numline3}'s/defaults/nosuid,nodev,noexec/' /etc/fstab

echo "#Step 9: Configure Partitions --> MSG: update /var partitions"
numline4=$(cat -n /etc/fstab | grep '/dev/mapper/'${myhost}'--vg-var /var' | awk '{print $1;}')
sed -i ${numline4}'s/defaults/nosuid,nodev/' /etc/fstab

echo "#Step 9: Configure Partitions --> MSG: add tmpfs at the end of /etc/fstab"
echo "tmpfs /dev/shm  tmpfs   rw,noexec,nosuid,nodev  0       0" >> /etc/fstab

echo "#Step 9: Configure Partitions --> MSG: Display /etc/fstab content"
cat /etc/fstab


echo "#########################################"
echo "#   Step 9: Configure Partitions - END  #"
echo "#########################################"
