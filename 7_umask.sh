#!/bin/bash

exec > ./7_umask.log 2>&1


echo "######################################"
echo "#   Step 7: Configure UMASK - START  #"
echo "######################################"

echo "#Step 7: Configure UMASK --> MSG: Save /etc/profile"
cp /etc/profile ./profile.save

echo "#Step 7: Configure UMASK --> MSG: Write umask 027 to /etc/profile"
sed -i '1iumask 027' /etc/profile

echo "#Step 7: Configure UMASK --> MSG: Display /etc/profile content"
cat /etc/profile

echo "#Step 7: Configure UMASK --> MSG: Save /etc/bash.bashrc"
cp /etc/bash.bashrc ./bash.bashrc.save

echo "#Step 7: Configure UMASK --> MSG: Write umask 027 to /etc/bash.bashrc"
sed -i '1iumask 027' /etc/bash.bashrc

echo "#Step 7: Configure UMASK --> MSG: Display /etc/bash.bashrc content"
cat /etc/bash.bashrc

echo "####################################"
echo "#   Step 7: Configure UMASK - END  #"
echo "####################################"
