#!/bin/bash


exec > ./23_firewall.log 2>&1

echo "###############################"
echo "#   Step 23: Firewall - START #"
echo "###############################"

apt-get install -y ufw

apt-get install -y gufw


#add rules
ufw default deny incoming
ufw default allow outgoing
ufw default deny routed
sudo ufw deny ssh
sudo ufw allow http
sudo ufw allow https

sudo ufw enable


echo "#############################"
echo "#   Step 23: Firewall - END #"
echo "#############################"


