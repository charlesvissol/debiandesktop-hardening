#!/bin/bash

exec > ./5_login_defs.log 2>&1

echo "#######################################"
echo "#   Step 5: Configure Logins - START  #"
echo "#######################################"


echo "#Step 5: Configure Logins --> MSG: Save /etc/login.defs"
mv /etc/login.defs ./login.defs.save

echo "#Step 5: Configure Logins --> MSG: Copy login.defs to /etc/"
cp ./login.defs /etc/login.defs

echo "#Step 5: Configure Logins --> MSG: Change to root owner"
chown root:root /etc/login.defs

echo "#Step 5: Configure Logins --> MSG: Display /etc/login.defs content"
cat /etc/login.defs

echo "#####################################"
echo "#   Step 5: Configure Logins - END  #"
echo "#####################################"
