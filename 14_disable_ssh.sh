#!/bin/bash

exec > ./14_disable_ssh.log 2>&1

echo "##################################"
echo "#   Step 14: Disable SSH - START #"
echo "##################################"

echo "#Step 14: Disable SSH --> MSG: set PermitRootLogin no"
echo "    PermitRootLogin no" >> /etc/ssh/ssh_config

echo "#Step 14: Disable SSH --> MSG: Verify /etc/ssh/ssh_config"
cat /etc/ssh/ssh_config

echo "################################"
echo "#   Step 14: Disable SSH - END #"
echo "################################"
 






