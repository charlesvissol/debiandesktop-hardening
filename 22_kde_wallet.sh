#!/bin/bash


exec > ./22_kde_wallet.log 2>&1

echo "###################################################"
echo "#   Step 22: Configure KDE Wallet Manager - START #"
echo "###################################################"

echo "#Step 22: Configure KDE Wallet Manager --> MSG: Uncomment line 'auth            optional        pam_kwallet5.so'"
numline1=$(cat -n /etc/pam.d/sddm | grep 'auth   optional        pam_kwallet5.so' | awk '{print $1;}')
sed -i ${numline1}'s/.*/auth   optional        pam_kwallet5.so/' /etc/pam.d/sddm


echo "#Step 22: Configure KDE Wallet Manager --> MSG: Uncomment line 'session optional       pam_kwallet5.so auto_start'"
numline2=$(cat -n /etc/pam.d/sddm | grep 'session optional       pam_kwallet5.so auto_start' | awk '{print $1;}')
sed -i ${numline2}'s/.*/session optional       pam_kwallet5.so auto_start/' /etc/pam.d/sddm


echo "#################################################"
echo "#   Step 22: Configure KDE Wallet Manager - END #"
echo "#################################################"


