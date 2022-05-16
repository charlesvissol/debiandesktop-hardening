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

exec > ./12_Sudoers.log 2>&1

echo "####################################"
echo "#   Step 12: Add Sudoers - START   #"
echo "####################################"

echo "Step 12: Add Sudoers  --> MSG: Backup /etc/sudoers"
cp /etc/sudoers ./sudoers.save

echo "Step 12: Add Sudoers  --> MSG: Add current user to /etc/sudoers to access su program"
sed -i '21s/.*/'$usernameroot'	ALL=(ALL:ALL) ALL/' /etc/sudoers
#sed '/'$usernameroot'	ALL=(ALL:ALL) ALL=.*/a after=root	ALL=(ALL:ALL) ALL^' ./sudoers.save
#awk '/root	ALL=(ALL:ALL) ALL/ {print; print "$usernameroot	ALL=(ALL:ALL) ALL"; next }1' ./sudoers.save

echo "Step 12: Add Sudoers  --> MSG: Deny su program to non admin users"
sudo dpkg-statoverride --update --add root sudo 4750 /bin/su

echo "Step 12: Add Sudoers  --> MSG: Secure /home of the users: "$usernameroot
chmod 0700 /home/$usernameroot
chmod +t /home/$usernameroot

echo "Step 12: Add Sudoers  --> MSG: Verify /home of "$usernameroot
stat /home/$usernameroot

echo "Step 12: Add Sudoers  --> MSG: Display /etc/sudoers content"
cat /etc/sudoers

echo "##################################"
echo "#   Step 12: Add Sudoers - END   #"
echo "##################################"
