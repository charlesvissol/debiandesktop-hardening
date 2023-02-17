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

exec > ./29_clean_package_cache.log 2>&1

echo "##########################################"
echo "#   Step 29: Clean Package Cache - START #"
echo "##########################################"


echo "Step 29: Clean Package Cache --> MSG: autoremove"
apt-get autoremove -y


echo "Step 29: Clean Package Cache --> MSG: clean"
apt-get clean -y

echo "########################################"
echo "#   Step 29: Clean Package Cache - END #"
echo "########################################"

 
