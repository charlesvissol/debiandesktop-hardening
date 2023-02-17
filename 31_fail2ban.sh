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

exec > ./31_fail2ban.log 2>&1

echo "###################################################"
echo "#   Step 31: Fail2ban intrusion detection - START #"
echo "###################################################"


echo "Step 31: Fail2ban intrusion detection --> MSG: installation"
apt-get install -y fail2ban

echo "Step 31: Fail2ban intrusion detection --> MSG: configuration"
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sed -i 's/bantime\s=\s600/bantime = 3600/g' /etc/fail2ban/jail.local
sed -i 's/findtime\s=\s600/findtime = 3600/g' /etc/fail2ban/jail.local

echo "Step 31: Fail2ban intrusion detection --> MSG: restart service"
systemctl restart fail2ban

echo "#################################################"
echo "#   Step 31: Fail2ban intrusion detection - END #"
echo "#################################################"
