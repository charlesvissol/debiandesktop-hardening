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

echo -n "Enter username to add to root (only One for this system!): "
read usernameroot


exec > ./17_firejail.log 2>&1

echo "#########################################################"
echo "#   Step 17: Install and configuration Firejail - START #"
echo "#########################################################"

echo "Step 17: Install and configuration Firejail --> MSG: Install the package"
apt-get install firejail -y
apt-get install apparmor-utils -y

echo "Step 17: Install and configuration Firejail --> MSG: Configure firejail by default"
aa-enforce firejail-default

echo "Step 17: Install and configuration Firejail --> MSG: Backup apparmor firejail configuration"
cp /etc/apparmor.d/firejail-default ./firejail-default.save

echo "Step 17: Install and configuration Firejail --> MSG: Backup firejail configuration"
cp /etc/firejail/firejail.config ./firejail.config.save

echo "Step 17: Install and configuration Firejail --> MSG: Copy Desktop shortcut to firejail"
cp ./firejail-firefox-esr.desktop /home/$usernameroot/Desktop/firejail-firefox-esr.desktop
chown $usernameroot:$usernameroot /home/$usernameroot/Desktop/firejail-firefox-esr.desktop
chmod ugo+x /home/$usernameroot/Desktop/firejail-firefox-esr.desktop


echo "#######################################################"
echo "#   Step 17: Install and configuration Firejail - END #"
echo "#######################################################"

 






