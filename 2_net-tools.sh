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

exec > ./2_net-tools.log 2>&1

echo "################################"
echo "#   Step 2: Net Tools - START  #"
echo "################################"



echo "#Step 2: Net Tools --> MSG: Install net-tools"
sudo apt-get install -y net-tools

echo "#Step 2: Net Tools --> MSG: Verification install net-tools"
apt search net-tools

echo "#Step 2: Net Tools --> MSG: Check open ports"
netstat -tap | grep LISTEN

echo "##############################"
echo "#   Step 2: Net Tools - END  #"
echo "##############################"
