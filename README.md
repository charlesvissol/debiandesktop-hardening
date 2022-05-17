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

Those auditd scripts come with predefined `*.rules` files provided in the current repository. 

Here you can install and configure `AIDE`:

-  `15_aide.sh`

The next script is specific for Laptops where you don't use SSH:

- `14_disable_ssh.sh`

Here you configure a minimum of `ufw` firewall rules and you install also the UI (`gufw`) but it is possible to deactivate it. Feel free to modify it:

- `23_firewall.sh`

The following scripts are more dedicated to the KDE environment:

- `16_antivirus.sh`: install `clamAV` and `clamTk`

- `17_firejail.sh` : this script install `firejail` and create a shortcut to use `firejail` combined to `firefox`. It uses `firejail-firefox-esr.desktop` file provided in the repository.

- `18_stacer.sh`: This script install `stacer`, very useful tool. `stacer.desktop` is provided with that script in the repository.

- `19_virtualbox.sh`: this script install automatically VirtualBox 6.1 from local DEB package (download previously `virtualbox-6.1_6.1.34-150636.1~Debian~bullseye_amd64.deb`). To finalize the installation, you need to manually install extension pack  (`Oracle_VM_VirtualBox_Extension_Pack-6.1.34.vbox-extpack`). You need also to download extension pack file. We provide `virtualbox.desktop` in this repository.

- `20_marktext.sh`: install `markext`, but previously download `marktext-amd64.deb`. We provide the shortcut `marktext.desktop` in the repository. `marktext` is a promising open source markdown editor.

- `21_tor_browser.sh`: install Tor Browser from `tor-browser-linux64-11.0.11_en-US.tar.xz`. So you need to download `tor` before executing the script.

Next script ease the password management over KDE Wallet and especially to retrieve Wifi connection when you reopen a KDE session:

- `22_kde_wallet.sh`

The last script helps you retrieving all technical information of your computer:

- `24_GetSystemInfos.sh`  


Synthesis: additional resources to download before executing scripts:
- `tor-browser-linux64-11.0.11_en-US.tar.xz`
- `virtualbox-6.1_6.1.34-150636.1~Debian~bullseye_amd64.deb`
- `Oracle_VM_VirtualBox_Extension_Pack-6.1.34.vbox-extpack`
- `marktext-amd64.deb`
To simplify the download of these resources, we provide you `00_Resources.sh` to execute first to retrieve locally the necessary files.

Have a good time :-)






