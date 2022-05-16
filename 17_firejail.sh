#!/bin/bash

echo -n "Enter username to add to root (only One for this system!): "
read usernameroot


exec > ./17_firejail.log 2>&1

echo "#########################################################"
echo "#   Step 17: Install and configuration Firejail - START #"
echo "#########################################################"

echo "Step 17: Install and configuration Firejail --> MSG: Install the package"
apt-get install firejail -y
apt-get install apparmor-utils -y

echo "Step 17: Install and configuration Firejail --> MSG: Configure firejail by default"
aa-enforce firejail-default

echo "Step 17: Install and configuration Firejail --> MSG: Backup apparmor firejail configuration"
cp /etc/apparmor.d/firejail-default ./firejail-default.save

echo "Step 17: Install and configuration Firejail --> MSG: Backup firejail configuration"
cp /etc/firejail/firejail.config ./firejail.config.save

echo "Step 17: Install and configuration Firejail --> MSG: Copy Desktop shortcut to firejail"
cp ./firejail-firefox-esr.desktop /home/$usernameroot/Desktop/firejail-firefox-esr.desktop
chown $usernameroot:$usernameroot /home/$usernameroot/Desktop/firejail-firefox-esr.desktop
chmod ugo+x /home/$usernameroot/Desktop/firejail-firefox-esr.desktop


echo "#######################################################"
echo "#   Step 17: Install and configuration Firejail - END #"
echo "#######################################################"

 






