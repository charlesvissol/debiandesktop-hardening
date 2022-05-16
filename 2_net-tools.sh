#!/bin/bash

exec > ./2_net-tools.log 2>&1

echo "################################"
echo "#   Step 2: Net Tools - START  #"
echo "################################"



echo "#Step 2: Net Tools --> MSG: Install net-tools"
sudo apt-get install -y net-tools

echo "#Step 2: Net Tools --> MSG: Verification install net-tools"
apt search net-tools

echo "#Step 2: Net Tools --> MSG: Check open ports"
netstat -tap | grep LISTEN

echo "##############################"
echo "#   Step 2: Net Tools - END  #"
echo "##############################"
