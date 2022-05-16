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

exec > ./4_common-password.log 2>&1

echo "##########################################"
echo "#   Step 4: Configure passwords - START  #"
echo "##########################################"


echo "#Step 4: Configure passwords --> MSG: Save /etc/pam.d/common-password"
mv /etc/pam.d/common-password ./common-password.save

echo "#Step 4: Configure passwords --> MSG: Copy common-password to /etc/pam.d/"
cp ./common-password /etc/pam.d/common-password

echo "#Step 4: Configure passwords --> MSG: Change to root owner"
chown root:root /etc/pam.d/common-password

echo "#Step 4: Configure passwords --> MSG: Display /etc/pam.d/common-password content"
cat /etc/pam.d/common-password

echo "########################################"
echo "#   Step 4: Configure passwords - END  #"
echo "########################################"
