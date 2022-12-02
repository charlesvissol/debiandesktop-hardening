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

exec > ./27_MS_teams_via_Snapd.log 2>&1

echo "#########################################################"
echo "#   Step 27: Install MS Teams - START #"
echo "#########################################################"


#Installation de snapd

echo "Step 27: Snapd --> MSG: Install snapd"
sudo apt -y install snapd

echo "Step 27: Snapd --> MSG: Install core from Snap"
sudo snap install core

echo "Step 27: Snapd --> MSG: Install MS Teams from snap"
sudo snap install teams



echo "#######################################################"
echo "#   Step 27: Install MS Teams - END #"
echo "#######################################################"

 
