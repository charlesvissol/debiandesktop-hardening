#!/bin/bash

exec > ./11_auditd.log 2>&1

echo "#####################################################"
echo "#   Step 11: Install and  configure auditd - START  #"
echo "#####################################################"

echo "#Step 11: Install and  configure auditd  --> MSG: Install auditd and plugins"
apt-get install -y auditd audispd-plugins

echo "#Step 11: Install and  configure auditd  --> MSG: Verify installation"
apt search auditd 
apt search audispd-plugins

echo "#Step 11: Install and  configure auditd  --> MSG: Backup audit.rules"
cp /etc/audit/rules.d/audit.rules ./audit.rules.save

echo "#Step 11: Install and  configure auditd  --> MSG: Add rules"
echo "# insmod Execution, rmmod and modprobe" >> /etc/audit/rules.d/audit.rules
echo "-w /sbin/insmod -p x" >> /etc/audit/rules.d/audit.rules
echo "-w /sbin/modprobe -p x" >> /etc/audit/rules.d/audit.rules
echo "-w /sbin/rmmod -p x" >> /etc/audit/rules.d/audit.rules
echo "# Audit /etc/ modifications" >> /etc/audit/rules.d/audit.rules
echo "-w /etc/ -p wa" >> /etc/audit/rules.d/audit.rules
echo "# Audit mount/Unmount" >> /etc/audit/rules.d/audit.rules
echo "-a exit,always -F arch=b64 -S mount -S umount2" >> /etc/audit/rules.d/audit.rules
echo "# Audit syscalls x86 suspects" >> /etc/audit/rules.d/audit.rules
echo "-a exit,always -F arch=b64 -S ioperm -S modify_ldt" >> /etc/audit/rules.d/audit.rules
echo "# Audit rare syscalls" >> /etc/audit/rules.d/audit.rules
echo "-a exit,always -F arch=b64 -S get_kernel_syms -S ptrace" >> /etc/audit/rules.d/audit.rules
echo "-a exit,always -F arch=b64 -S prctl" >> /etc/audit/rules.d/audit.rules
echo "-a exit,always -F arch=b64 -S unlink -S rmdir -S rename" >> /etc/audit/rules.d/audit.rules

echo "# Lock auditd configuration" >> /etc/audit/rules.d/audit.rules
echo "-e 2" >> /etc/audit/rules.d/audit.rules

echo "#Step 11: Install and  configure auditd  --> MSG: Copy /etc/audit/rules.d/system-locale.rules"
cp ./system-locale.rules /etc/audit/rules.d/system-locale.rules
chown root:root /etc/audit/rules.d/system-locale.rules

echo "#Step 11: Install and  configure auditd  --> MSG: Copy /etc/audit/rules.d/accesses.rules"
cp ./accesses.rules /etc/audit/rules.d/accesses.rules
chown root:root /etc/audit/rules.d/accesses.rules

echo "#Step 11: Install and  configure auditd  --> MSG: Copy /etc/audit/rules.d/mounts.rules"
cp ./mounts.rules /etc/audit/rules.d/mounts.rules
chown root:root /etc/audit/rules.d/mounts.rules

echo "#Step 11: Install and  configure auditd  --> MSG: Copy /etc/audit/rules.d/scope.rules"
cp ./scope.rules /etc/audit/rules.d/scope.rules
chown root:root /etc/audit/rules.d/scope.rules

echo "#Step 11: Install and  configure auditd  --> MSG: Copy /etc/audit/rules.d/root.rules"
cp ./root.rules /etc/audit/rules.d/root.rules
chown root:root /etc/audit/rules.d/root.rules

echo "#Step 11: Install and  configure auditd  --> MSG: Display audit.rules content"
cat /etc/audit/rules.d/audit.rules

echo "#Step 11: Install and  configure auditd  --> MSG: List *.rules files"
ls -l /etc/audit/rules.d

echo "#Step 11: Install and  configure auditd  --> MSG: Backup auditd.conf"
cp /etc/audit/auditd.conf ./auditd.conf.save

echo "#Step 11: Install and  configure auditd --> MSG: max_log_file = 20"
numline1=$(cat -n /etc/audit/auditd.conf | grep 'max_log_file' | awk '{print $1;}')
sed -i ${numline1}'s/.*/max_log_file = 20/' /etc/audit/auditd.conf

echo "#Step 11: Install and  configure auditd --> MSG: num_logs = 10"
numline2=$(cat -n /etc/audit/auditd.conf | grep 'num_logs' | awk '{print $1;}')
sed -i ${numline2}'s/.*/num_logs = 10/' /etc/audit/auditd.conf

echo "#Step 11: Install and  configure auditd --> MSG: log_format = RAW"
numline2=$(cat -n /etc/audit/auditd.conf | grep 'log_format' | awk '{print $1;}')
sed -i ${numline2}'s/.*/log_format = RAW/' /etc/audit/auditd.conf


echo "#Step 11: Install and  configure auditd --> MSG: Display auditd.conf parameters modified"
cat /etc/audit/auditd.conf | grep 'max_log_file ='
cat /etc/audit/auditd.conf | grep 'num_logs ='
cat /etc/audit/auditd.conf | grep 'log_format ='

echo "#Step 11: Install and  configure auditd --> MSG: Restart auditd service"
systemctl restart auditd

echo "#Step 11: Install and  configure auditd --> MSG: Get auditd status"
systemctl status auditd


echo "###################################################"
echo "#   Step 11: Install and  configure auditd - END  #"
echo "###################################################"



