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

exec > ./30_disable_dumps.log 2>&1

echo "####################################"
echo "#   Step 30: Disable Dumps - START #"
echo "####################################"


#Installation de snapd
echo "Step 30: Disable Dumps --> MSG: disable core dumps"
echo "* hard core 0" >> /etc/security/limits.conf


echo "##################################"
echo "#   Step 30: Disable Dumps - END #"
echo "##################################"

 
