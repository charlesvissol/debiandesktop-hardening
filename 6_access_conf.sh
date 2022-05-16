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

exec > ./6_access_conf.log 2>&1

echo "#######################################"
echo "#   Step 6: Configure Access - START  #"
echo "#######################################"

echo "#Step 6: Configure Access --> MSG: Save /etc/security/access.conf"
mv /etc/security/access.conf ./access.conf.save

echo "#Step 6: Configure Access --> MSG: Copy access.conf to /etc/security"
cp ./access.conf /etc/security/access.conf

echo "#Step 6: Configure Access --> MSG: Change to root owner"
chown root:root /etc/security/access.conf

echo "#Step 6: Configure Access --> MSG: Display /etc/security/access.conf content"
cat /etc/security/access.conf

echo "#####################################"
echo "#   Step 6: Configure Access - END  #"
echo "#####################################"
