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

echo -n "Enter username to add desktop shortcut: "
read usernameroot


exec > ./19_virtualbox.log 2>&1

echo "###########################################################"
echo "#   Step 19: Install and configuration VirtualBox - START #"
echo "###########################################################"

echo "Step 19: Install and configuration VirtualBox --> MSG: Install package VirtualBox"
apt-get install -y ./virtualbox-7.0_7.0.14-161095~Debian~bookworm_amd64.deb

echo "Step 19: Install and configuration VirtualBox --> MSG: Copy Desktop shortcut to VirtualBox"
cp ./virtualbox.desktop /home/$usernameroot/Desktop/virtualbox.desktop
chown $usernameroot:$usernameroot /home/$usernameroot/Desktop/virtualbox.desktop
chmod ugo+x /home/$usernameroot/Desktop/virtualbox.desktop


echo "Step 19: Install and configuration VirtualBox --> MSG: /!\ Do not forget to install Oracle_VM_VirtualBox_Extension_Pack-6.1.34.vbox-extpack /!\ "

echo "#########################################################"
echo "#   Step 19: Install and configuration VirtualBox - END #"
echo "#########################################################"

 
