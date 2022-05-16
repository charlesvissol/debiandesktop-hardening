# debiandesktop-hardening

This repository's goal aims to help you hardening your Debian11.x/KDE environment to use it securely on the internet.

I have made several Shell scripts to allow you selecting the script corresponding to needs.

Each script starts with a number which is the order to run them.

Put all those scripts and additional resources in the same directory.



Scripts dedicated to Debian hardening (fits to any Debian environment):

- `1_secure_cron.sh`

- `2_net-tools.sh`

- `3_libpam`

- `4_common-password.sh`: works with `common-password`

- `5_login_defs.sh`: works with `login.defs`

- `10_sysctl_conf.sh`

- `6_access_conf.sh`: works with `access.conf`

- `7_umask.sh`

- `8_secure_important_files.sh`

- `9_partitions_conf.sh`

- `12_Sudoers.sh`

- `13_secure_boot.sh`




The next scripts are dedicated to the installation and the configuration of `auditd`:

- `11_auditd.sh`

- `11_auditd_option.sh`: this script is optional because it can impact performances.


Those auditd scripts come with predefined `*.rules` files. 



Here you can install and configure `AIDE`:

-  `15_aide.sh`




This script is specific for Laptops where you don't use SSH:

- `14_disable_ssh.sh`



Here you configure a minimum of `ufw` firewall and you install also the UI (`gufw`) but it is possible to deactivate it. Feel free to modify it:

- `23_firewall.sh`


The following scripts are more dedicated to the KDE environment:

- `16_antivirus.sh`: install clamAV and clamTk

- `17_firejail.sh` : this script install `Firejail` and create a shortcut to use `Firejail` combined to `Firefox`. It uses `*.desktop` file.

- `18_stacer.sh`: This script install Stacer, very useful... `*.desktop` is provided with that script.

- `19_virtualbox.sh`: this script install automatically VirtualBox 6.1 from local DEB package. To finalize the installation, you need to manually install extension pack available with the scripts (`Oracle_VM_VirtualBox_Extension_Pack-6.1.34.vbox-extpack`). `*.desktop` is provided with that script.

- `20_marktext.sh`: install marktext, and open source markdown editor. DEB is provided with the scripts and `*.desktop` also.

- `21_tor_browser.sh`: install Tor Browser from `tor-browser-linux64-11.0.11_en-US.tar.xz` at /home/$username/Softs


Here is a script to ease the password management over KDE Wallet and especially to retrieve Wifi connection when you reopen a session:

- `22_kde_wallet.sh`


This script helps you retrieving all technical information of your computer:

- `24_GetSystemInfos.sh`  
