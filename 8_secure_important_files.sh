#!/bin/bash

exec > ./8_secure_important_files.log 2>&1

echo "#############################################"
echo "#   Step 8: Secure important files - START  #"
echo "#############################################"

echo "#Step 8: Secure important files --> MSG: Verification important files Before"
stat /etc/passwd- 
stat /etc/group-

echo "#Step 8: Secure important files --> MSG: secure /etc/passwd-"
chmod 000 /etc/passwd-

echo "#Step 8: Secure important files --> MSG: secure /etc/group-"
chmod 000 /etc/group-

echo "#Step 8: Secure important files --> MSG: Verification important files After"
stat /etc/passwd- 
stat /etc/group-

echo "###########################################"
echo "#   Step 8: Secure important files - END  #"
echo "###########################################"
