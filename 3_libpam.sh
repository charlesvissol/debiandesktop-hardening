#!/bin/bash

exec > ./3_libpam.log 2>&1

echo "#######################################"
echo "#   Step 3: Install PAM libs - START  #"
echo "#######################################"


echo "#Step 3: Install PAM libs --> MSG: Install libpam-pwquality"
sudo apt install -y libpam-pwquality

echo "#Step 3: Install PAM libs --> MSG: Install libpam-shield"
sudo apt install -y libpam-shield

echo "#Step 3: Install PAM libs --> MSG: Install libpam-tmpdir"
sudo apt install -y libpam-tmpdir

echo "#Step 3: Install PAM libs --> MSG: Verification"
apt search libpam-pwquality
apt search libpam-shield
apt search libpam-tmpdir

echo "#####################################"
echo "#   Step 3: Install PAM libs - END  #"
echo "#####################################"
