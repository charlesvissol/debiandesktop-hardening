#!/bin/bash

echo -n "Enter username to add to root (only One for this system!): "
read usernameroot


exec > ./20_marktext.log 2>&1

echo "#########################################################"
echo "#   Step 20: Install and configuration marktext - START #"
echo "#########################################################"

echo "Step 20: Install and configuration marktext --> MSG: Install package marktext"
apt-get install -y ./marktext-amd64.deb

echo "Step 20: Install and configuration marktext --> MSG: Copy Desktop shortcut to marktext"
cp ./marktext.desktop /home/$usernameroot/Desktop/marktext.desktop
chown $usernameroot:$usernameroot /home/$usernameroot/Desktop/marktext.desktop
chmod ugo+x /home/$usernameroot/Desktop/marktext.desktop

echo "#######################################################"
echo "#   Step 20: Install and configuration marktext - END #"
echo "#######################################################"

 
