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


exec > ./20_marktext.log 2>&1

echo "#########################################################"
echo "#   Step 20: Install and configuration marktext - START #"
echo "#########################################################"

echo "Step 20: Install and configuration marktext --> MSG: Install package marktext"
apt-get install -y ./marktext-amd64.deb

echo "Step 20: Install and configuration marktext --> MSG: Copy Desktop shortcut to marktext"
cp ./marktext.desktop /home/$usernameroot/Desktop/marktext.desktop
chown $usernameroot:$usernameroot /home/$usernameroot/Desktop/marktext.desktop
chmod ugo+x /home/$usernameroot/Desktop/marktext.desktop

echo "#######################################################"
echo "#   Step 20: Install and configuration marktext - END #"
echo "#######################################################"

 
