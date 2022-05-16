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


exec > ./18_stacer.log 2>&1

echo "#########################################################"
echo "#   Step 18: Install and configuration Stacer - START #"
echo "#########################################################"

echo "Step 18: Install and configuration Stacer --> MSG: Install the package"
apt-get install stacer -y


echo "Step 18: Install and configuration Stacer --> MSG: Copy Desktop shortcut to Stacer"
cp ./stacer.desktop /home/$usernameroot/Desktop/stacer.desktop
chown $usernameroot:$usernameroot /home/$usernameroot/Desktop/stacer.desktop
chmod ugo+x /home/$usernameroot/Desktop/stacer.desktop


echo "#####################################################"
echo "#   Step 18: Install and configuration Stacer - END #"
echo "#####################################################"








