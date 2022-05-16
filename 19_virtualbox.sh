#!/bin/bash

echo -n "Enter username to add to root (only One for this system!): "
read usernameroot


exec > ./19_virtualbox.log 2>&1

echo "###########################################################"
echo "#   Step 19: Install and configuration VirtualBox - START #"
echo "###########################################################"

echo "Step 19: Install and configuration VirtualBox --> MSG: Install package VirtualBox"
apt-get install -y ./virtualbox-6.1_6.1.34-150636.1~Debian~bullseye_amd64.deb

echo "Step 19: Install and configuration VirtualBox --> MSG: Copy Desktop shortcut to VirtualBox"
cp ./virtualbox.desktop /home/$usernameroot/Desktop/virtualbox.desktop
chown $usernameroot:$usernameroot /home/$usernameroot/Desktop/virtualbox.desktop
chmod ugo+x /home/$usernameroot/Desktop/virtualbox.desktop


echo "Step 19: Install and configuration VirtualBox --> MSG: /!\ Do not forget to install Oracle_VM_VirtualBox_Extension_Pack-6.1.34.vbox-extpack /!\ "

echo "#########################################################"
echo "#   Step 19: Install and configuration VirtualBox - END #"
echo "#########################################################"

 
