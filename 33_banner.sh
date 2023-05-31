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

echo "Enter your company name"
read company_name

exec > ./33_banner.log 2>&1

echo "##################################################"
echo "#   Step 33: Adding a banner to terminal - START #"
echo "##################################################"

# banner
echo "*** Creating the Banner with custom company name ***"
banner="Warning !! This system is restricted to authorized individuals ans is the property of $company_name. Unauthorized access is prohibited."

# add banner in the files
echo "*** Adding a banner in /etc/issue file ***"
echo "$banner" > /etc/issue
echo "*** Adding a banner in /etc/issue.net file ***"
echo "$banner" > /etc/issue.net

echo "##################################################"
echo "#   Step 33: Adding a banner to terminal - END   #"
echo "##################################################"
