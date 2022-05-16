#!/bin/bash

echo -n "Enter username to add to root (only One for this system!): "
read usernameroot

exec > ./16_antivirus.log 2>&1

echo "##########################################################"
echo "#   Step 16: Install and configuration Antivirus - START #"
echo "##########################################################"

echo "Step 16: Install and configuration Antivirus --> MSG: Install the package"
apt-get install clamav clamav-daemon -y
apt-get install clamtk -y


echo "Step 16: Install and configuration Antivirus --> MSG: Manually update ClamAV signature database"
systemctl stop clamav-freshclam
sudo freshclam
systemctl start clamav-freshclam

echo "#Step 16: Install and configuration Antivirus --> MSG: check original /etc/clamav/clamd.conf"
cat /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule DetectPUA"
numline1=$(cat -n /etc/clamav/clamd.conf | grep 'DetectPUA ' | awk '{print $1;}')
sed -i ${numline1}'s/.*/DetectPUA true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule ScanMail"
numline2=$(cat -n /etc/clamav/clamd.conf | grep 'ScanMail ' | awk '{print $1;}')
sed -i ${numline2}'s/.*/ScanMail true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule ScanArchive"
numline3=$(cat -n /etc/clamav/clamd.conf | grep 'ScanArchive ' | awk '{print $1;}')
sed -i ${numline3}'s/.*/ScanArchive true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule LogRotate"
numline4=$(cat -n /etc/clamav/clamd.conf | grep 'LogRotate ' | awk '{print $1;}')
sed -i ${numline4}'s/.*/LogRotate true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule ScanPE"
numline5=$(cat -n /etc/clamav/clamd.conf | grep 'ScanPE ' | awk '{print $1;}')
sed -i ${numline5}'s/.*/ScanPE true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule ScanPDF"
numline6=$(cat -n /etc/clamav/clamd.conf | grep 'ScanPDF ' | awk '{print $1;}')
sed -i ${numline6}'s/.*/ScanPDF true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule ScanHTML"
numline7=$(cat -n /etc/clamav/clamd.conf | grep 'ScanHTML ' | awk '{print $1;}')
sed -i ${numline7}'s/.*/ScanHTML true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule AlgorithmicDetection"
numline8=$(cat -n /etc/clamav/clamd.conf | grep 'AlgorithmicDetection ' | awk '{print $1;}')
sed -i ${numline8}'s/.*/AlgorithmicDetection true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule ScanELF"
numline9=$(cat -n /etc/clamav/clamd.conf | grep 'ScanELF ' | awk '{print $1;}')
sed -i ${numline9}'s/.*/ScanELF true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule CrossFilesystems"
numline10=$(cat -n /etc/clamav/clamd.conf | grep 'CrossFilesystems ' | awk '{print $1;}')
sed -i ${numline10}'s/.*/CrossFilesystems true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule PhishingSignatures"
numline11=$(cat -n /etc/clamav/clamd.conf | grep 'PhishingSignatures ' | awk '{print $1;}')
sed -i ${numline11}'s/.*/PhishingSignatures true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule PhishingScanURLs"
numline12=$(cat -n /etc/clamav/clamd.conf | grep 'PhishingScanURLs ' | awk '{print $1;}')
sed -i ${numline12}'s/.*/PhishingScanURLs true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule DetectPUA"
numline13=$(cat -n /etc/clamav/clamd.conf | grep 'DetectPUA ' | awk '{print $1;}')
sed -i ${numline13}'s/.*/DetectPUA true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule ExtendedDetectionInfo"
numline14=$(cat -n /etc/clamav/clamd.conf | grep 'ExtendedDetectionInfo ' | awk '{print $1;}')
sed -i ${numline14}'s/.*/ExtendedDetectionInfo true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule AllowAllMatchScan"
numline15=$(cat -n /etc/clamav/clamd.conf | grep 'AllowAllMatchScan ' | awk '{print $1;}')
sed -i ${numline15}'s/.*/AllowAllMatchScan true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule ScanXMLDOCS"
numline16=$(cat -n /etc/clamav/clamd.conf | grep 'ScanXMLDOCS ' | awk '{print $1;}')
sed -i ${numline16}'s/.*/ScanXMLDOCS true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule ScanHWP3"
numline17=$(cat -n /etc/clamav/clamd.conf | grep 'ScanHWP3 ' | awk '{print $1;}')
sed -i ${numline17}'s/.*/ScanHWP3 true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule LogTime"
numline18=$(cat -n /etc/clamav/clamd.conf | grep 'LogTime ' | awk '{print $1;}')
sed -i ${numline18}'s/.*/LogTime true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Update rule Bytecode"
numline18=$(cat -n /etc/clamav/clamd.conf | grep 'Bytecode ' | awk '{print $1;}')
sed -i ${numline18}'s/.*/Bytecode true/' /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Add rules OnAccessIncludePath and OnAccessPrevention"
echo "OnAccessIncludePath /home/"$usernameroot"/Downloads" >> /etc/clamav/clamd.conf
echo "OnAccessPrevention yes" >> /etc/clamav/clamd.conf
echo "OnAccessExcludeUname clamd" >> /etc/clamav/clamd.conf


echo "#Step 16: Install and configuration Antivirus --> MSG: check updated /etc/clamav/clamd.conf"
cat /etc/clamav/clamd.conf

echo "#Step 16: Install and configuration Antivirus --> MSG: Restart services"
systemctl restart clamav-freshclam
systemctl restart clamav-daemon
clamonacc

echo "########################################################"
echo "#   Step 16: Install and configuration Antivirus - END #"
echo "########################################################"
 






