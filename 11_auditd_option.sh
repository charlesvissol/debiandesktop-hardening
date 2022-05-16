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

exec > ./11_auditd_option.log 2>&1

echo "##############################################################"
echo "#   Step 11 (Option): Install and  configure auditd - START  #"
echo "##############################################################"


echo "#Step 11 (Option): Install and  configure auditd  --> MSG: Copy /etc/audit/rules.d/time.rules"
cp ./time.rules /etc/audit/rules.d/time.rules
chown root:root /etc/audit/rules.d/time.rules

echo "#Step 11 (Option): Install and  configure auditd  --> MSG: Copy /etc/audit/rules.d/identity.rules"
cp ./identity.rules /etc/audit/rules.d/identity.rules
chown root:root /etc/audit/rules.d/identity.rules

echo "#Step 11 (Option): Install and  configure auditd  --> MSG: Copy /etc/audit/rules.d/logins.rules"
cp ./logins.rules /etc/audit/rules.d/logins.rules
chown root:root /etc/audit/rules.d/logins.rules

echo "#Step 11 (Option): Install and  configure auditd  --> MSG: Copy /etc/audit/rules.d/permissions.rules"
cp ./permissions.rules /etc/audit/rules.d/permissions.rules
chown root:root /etc/audit/rules.d/permissions.rules

echo "#Step 11 (Option): Install and  configure auditd --> MSG: Verify *.rules files"
stat /etc/audit/rules.d/time.rules
stat /etc/audit/rules.d/identity.rules
stat /etc/audit/rules.d/logins.rules
stat /etc/audit/rules.d/permissions.rules

echo "#Step 11 (Option): Install and  configure auditd --> MSG: Restart auditd service"
systemctl restart auditd

echo "#Step 11 (Option): Install and  configure auditd --> MSG: Get auditd status"
systemctl status auditd


echo "############################################################"
echo "#   Step 11 (Option): Install and  configure auditd - END  #"
echo "############################################################"



