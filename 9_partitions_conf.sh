#!/bin/bash

# Copyright 2022 Angrybee.tech (https://angrybee.tech)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
