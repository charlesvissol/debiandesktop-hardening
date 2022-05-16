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

exec > ./15_aide.log 2>&1

echo "#####################################################"
echo "#   Step 15: Install and configuration AIDE - START #"
echo "#####################################################"

echo "#Step 15: Install and configuration AIDE --> MSG: Install the package"
apt install -y aide

echo "#Step 15: Install and configuration AIDE --> MSG: Add the exclusion for user files"
echo "!/run/user/.*" >> /etc/aide/aide.conf

echo "#Step 15: Install and configuration AIDE --> MSG: Verify the configuration"
aide -c /etc/aide/aide.conf --config-check

echo "#Step 15: Install and configuration AIDE --> MSG: Update the configuration"
aide -c /etc/aide/aide.conf --update

echo "#Step 15: Install and configuration AIDE --> MSG: Initialize the database"
aideinit -y -f

echo "###################################################"
echo "#   Step 15: Install and configuration AIDE - END #"
echo "###################################################"
 






