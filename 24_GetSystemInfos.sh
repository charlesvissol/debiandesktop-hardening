#!/bin/bash


exec > ./24_GetSystemInfo.log 2>&1

echo "#############################################"
echo "#   Step 24: Get System information - START #"
echo "#############################################"

echo "#Step 24: Get System information --> MSG: Install lshw utility"
apt-get install -y lshw

echo "#Step 24: Get System information --> MSG: Exec hostnamectl"
hostnamectl

echo "#Step 24: Get System information --> MSG: Exec lscpu"
lscpu

echo "#Step 24: Get System information --> MSG: Exec lshw"
lshw

echo "###########################################"
echo "#   Step 24: Get System information - END #"
echo "###########################################"


