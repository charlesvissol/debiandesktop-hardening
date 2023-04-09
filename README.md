# debiandesktop-hardening

> Important
> For Debian 11.6 KDE Desktop with the 2.4 release of these script Lynis audit score is **79/100**.
<br>
This repository's goal aims to help you hardening your Debian11.x/KDE environment and use it securely on the internet.

I have made several Shell scripts to allow you selecting the script corresponding to your needs.

Each script starts with a number corresponding to the order of execution.

Before executing them make them *executable* (`chmod`...)

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

> If you really want to push the limits of hardening with auditd, I recommend you to go to https://github.com/Neo23x0/auditd. this is a very interesting set of rules.


## Release 1.8:
- Add `update_upgrade.sh` script to automate the update & upgrade process of Debian/Ubuntu
- Add `25_samba.sh` to automate the attachment of a Samba shared folder to the Debian/Ubuntu environment

## Release 1.9:
- Add script `26_Docker.sh` to install Docker CE, Docker CE client, containerd.io and Docker compose plugin

## Release 2.0:
- Update of the `19_virtualbox.sh`to adapt it to the last version of VirtualBox (Release 7)

## Release 2.1:
- Add script `27_MS_teams_via_snapd.sh`to install automatically Ms Teams using snap installation

## Release 2.2:
- Add script `01_battery_control.sh`to check battery health
- Add script `02_bash_aliases.sh`to custom welcome message of the Terminal

## Release 2.2.1:
- Bug fixing of `02_bash_aliases.sh`


## Release 2.3:
5 security scripts added:
- `28_auto_security_updates.sh`: automate the security updates to maintain your system up-to-date
- `29_clean_package_cache.sh: a script to clean package cache
- `30_Disable_dumps.sh`: Disable core dumps
- `31_fail2ban.sh`: Enable fail2ban service
- `32_accounting_on.sh`: Enable process accounting

### Release 2.4:
1 Security audit added:
- `33_Lynis.sh`: Install the last version of Lynis and run a full system audit

Have a good time :-)






