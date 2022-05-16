#!/bin/bash

exec > ./6_access_conf.log 2>&1

echo "#######################################"
echo "#   Step 6: Configure Access - START  #"
echo "#######################################"

echo "#Step 6: Configure Access --> MSG: Save /etc/security/access.conf"
mv /etc/security/access.conf ./access.conf.save

echo "#Step 6: Configure Access --> MSG: Copy access.conf to /etc/security"
cp ./access.conf /etc/security/access.conf

echo "#Step 6: Configure Access --> MSG: Change to root owner"
chown root:root /etc/security/access.conf

echo "#Step 6: Configure Access --> MSG: Display /etc/security/access.conf content"
cat /etc/security/access.conf

echo "#####################################"
echo "#   Step 6: Configure Access - END  #"
echo "#####################################"
