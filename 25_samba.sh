#!/bin/bash

# Copyright 2022 Angrybee.tech (https://angrybee.tech)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



echo -n "Enter username: "
read username

echo -n "Enter Samba password: "
read password

echo -n "Enter IP address: "
read address


exec > ./25_samba.log 2>&1

echo "#############################################################################################"
echo "#   Step 25: This script allows you to create a Samba shared directory /media/public - START #"
echo "#############################################################################################"

echo "Step 25: Install cifs-utils package --> MSG: Install the package"
sudo apt install cifs-utils

echo "Step 25: Create /media/public folder --> MSG: create directory"
sudo mkdir /media/public

echo "Step 25: Create .smbcredentials file --> MSG: create credentials file"
touch "/home/"$username"/.smbcredentials"
echo "username=$username" >> /home/${username}/.smbcredentials
echo "password=$password" >> /home/${username}/.smbcredentials

echo "Step 25: Add device entry to fstab file --> MSG: Add entry to fstab file"
sudo echo "//"$address"/public   /media/public   cifs    credentials=/home/"$username"/.smbcredentials,user,rw,uid="$username >> /etc/fstab

echo "###################################################"
echo "#   Step 25: Samba shared directory created - END #"
echo "###################################################"
