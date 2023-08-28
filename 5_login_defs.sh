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

exec > ./5_login_defs.log 2>&1

echo "#######################################"
echo "#   Step 5: Configure Logins - START  #"
echo "#######################################"


echo "#Step 5: Configure Logins --> MSG: Save /etc/login.defs"
mv /etc/login.defs ./login.defs.save

echo "#Step 5: Configure Logins --> MSG: Copy login.defs to /etc/"
cp ./login.defs /etc/login.defs

echo "#Step 5: Configure Logins --> MSG: Change to root owner"
chown root:root /etc/login.defs

echo "#Step 5: Configure Logins --> MSG: Define max inactive age to 30 days"
useradd -D -f 30


echo "#Step 5: Configure Logins --> MSG: Display /etc/login.defs content"
cat /etc/login.defs

echo "#####################################"
echo "#   Step 5: Configure Logins - END  #"
echo "#####################################"
