#!/bin/bash

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



