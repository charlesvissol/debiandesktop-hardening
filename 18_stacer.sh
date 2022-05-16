#!/bin/bash

echo -n "Enter username to add to root (only One for this system!): "
read usernameroot


exec > ./18_stacer.log 2>&1

echo "#########################################################"
echo "#   Step 18: Install and configuration Stacer - START #"
echo "#########################################################"

echo "Step 18: Install and configuration Stacer --> MSG: Install the package"
apt-get install stacer -y


echo "Step 18: Install and configuration Stacer --> MSG: Copy Desktop shortcut to Stacer"
cp ./stacer.desktop /home/$usernameroot/Desktop/stacer.desktop
chown $usernameroot:$usernameroot /home/$usernameroot/Desktop/stacer.desktop
chmod ugo+x /home/$usernameroot/Desktop/stacer.desktop


echo "#####################################################"
echo "#   Step 18: Install and configuration Stacer - END #"
echo "#####################################################"








