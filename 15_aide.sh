#!/bin/bash

exec > ./15_aide.log 2>&1

echo "#####################################################"
echo "#   Step 15: Install and configuration AIDE - START #"
echo "#####################################################"

echo "#Step 15: Install and configuration AIDE --> MSG: Install the package"
apt install -y aide

echo "#Step 15: Install and configuration AIDE --> MSG: Add the exclusion for user files"
echo "!/run/user/.*" >> /etc/aide/aide.conf

echo "#Step 15: Install and configuration AIDE --> MSG: Verify the configuration"
aide -c /etc/aide/aide.conf --config-check

echo "#Step 15: Install and configuration AIDE --> MSG: Update the configuration"
aide -c /etc/aide/aide.conf --update

echo "#Step 15: Install and configuration AIDE --> MSG: Initialize the database"
aideinit -y -f

echo "###################################################"
echo "#   Step 15: Install and configuration AIDE - END #"
echo "###################################################"
 






