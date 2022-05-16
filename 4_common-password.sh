#!/bin/bash

exec > ./4_common-password.log 2>&1

echo "##########################################"
echo "#   Step 4: Configure passwords - START  #"
echo "##########################################"


echo "#Step 4: Configure passwords --> MSG: Save /etc/pam.d/common-password"
mv /etc/pam.d/common-password ./common-password.save

echo "#Step 4: Configure passwords --> MSG: Copy common-password to /etc/pam.d/"
cp ./common-password /etc/pam.d/common-password

echo "#Step 4: Configure passwords --> MSG: Change to root owner"
chown root:root /etc/pam.d/common-password

echo "#Step 4: Configure passwords --> MSG: Display /etc/pam.d/common-password content"
cat /etc/pam.d/common-password

echo "########################################"
echo "#   Step 4: Configure passwords - END  #"
echo "########################################"
