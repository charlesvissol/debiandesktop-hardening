#!/bin/bash

# Copyright 2023 Angrybee.tech (https://angrybee.tech)
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


echo "##################################################"
echo "#   Step 33: Adding a banner to terminal - START #"
echo "##################################################"

exec > ./33_banners.log 2>&1

# ask for root privileges
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

# banner
banner="Warning !! Be Careful about privacy. Data theft unauthorized !"

# add banner in the files
echo "$banner" > /etc/issue
echo "$banner" > /etc/issue.net

echo "##################################################"
echo "#   Step 33: Adding a banner to terminal - END   #"
echo "##################################################"