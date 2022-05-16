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

exec > ./14_disable_ssh.log 2>&1

echo "##################################"
echo "#   Step 14: Disable SSH - START #"
echo "##################################"

echo "#Step 14: Disable SSH --> MSG: set PermitRootLogin no"
echo "    PermitRootLogin no" >> /etc/ssh/ssh_config

echo "#Step 14: Disable SSH --> MSG: Verify /etc/ssh/ssh_config"
cat /etc/ssh/ssh_config

echo "################################"
echo "#   Step 14: Disable SSH - END #"
echo "################################"
 






