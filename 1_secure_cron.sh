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

exec > ./1_secure_cron.log 2>&1

echo "##################################"
echo "#   Step 1: Secure Cron - START  #"
echo "##################################"

echo "#Step 1: Secure Cron --> MSG: secure /etc/crontab"
chown root:root /etc/crontab
chmod og-rwx /etc/crontab

echo "#Step 1: Secure Cron --> MSG: Secure /etc/cron.hourly"
chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly

echo "#Step 1: Secure Cron --> MSG: Secure /etc/cron.daily"
chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily

echo "#Step 1: Secure Cron --> MSG: Secure /etc/cron.monthly"
chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly

echo "#Step 1: Secure Cron --> MSG: Secure /etc/cron.d"
chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d

echo "#Step 1: Secure Cron --> MSG: Restrict CRON access"
touch /etc/cron.allow
touch /etc/cron.deny
chmod og-rwx /etc/cron.allow
chmod og-rwx /etc/cron.deny


echo "#Step 1: Secure Cron --> MSG: Verify result"
ls -l /etc/crontab
ls -l /etc/cron.hourly
ls -l /etc/cron.daily
ls -l /etc/cron.monthly
ls -l /etc/cron.d
ls -l /etc/cron.allow
ls -l /etc/cron.deny


echo "################################"
echo "#   Step 1: Secure Cron - END  #"
echo "################################"
 






