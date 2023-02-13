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

echo -n "Enter current /home username: "
read usernameroot

echo -n "Enter Terminal Welcome message [Enter if no message]: "
read tmsg



exec > ./02_bash_aliases.log 2>&1

echo "#######################################"
echo "#   Step 02: Terminal Welcome - START #"
echo "#######################################"

echo "Step 02: Terminal Welcome --> MSG: Install linuxlogo"
apt-get install linuxlogo -y


echo "Step 02: Terminal Welcome --> MSG: .bash_aliases creation and modification"
touch /home/$usernameroot/.bash_aliases
chown $usernameroot:$usernameroot /home/$usernameroot/.bash_aliases
echo "cat<<'EOF'" > /home/$usernameroot/.bash_aliases
echo " " >> /home/$usernameroot/.bash_aliases
echo " "$tmsg" " >> /home/$usernameroot/.bash_aliases
echo " " >> /home/$usernameroot/.bash_aliases
echo "EOF" >> /home/$usernameroot/.bash_aliases
echo "linuxlogo" >> /home/$usernameroot/.bash_aliases


echo "######################################"
echo "#   Step 02: Terminal Welcome - STOP #"
echo "######################################"
 






