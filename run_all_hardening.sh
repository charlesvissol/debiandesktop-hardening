#!/bin/bash

# Copyright 2024 Angrybee.tech (https://angrybee.tech)
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

################################################################################
# AUTOMATION SCRIPT - DEBIAN DESKTOP HARDENING
# This script automates the execution of all hardening scripts in sequence
################################################################################

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Log file for the automation
AUTOMATION_LOG="./automation_$(date +%Y%m%d_%H%M%S).log"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}ERROR: This script must be run as root${NC}"
    echo "Please run: sudo bash $0"
    exit 1
fi

# Function to log messages
log_message() {
    local level=$1
    shift
    local message="$@"
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" | tee -a "$AUTOMATION_LOG"
}

# Function to execute a script
execute_script() {
    local script=$1
    log_message "INFO" "${BLUE}Starting execution of: $script${NC}"
    
    if [ ! -f "./$script" ]; then
        log_message "ERROR" "${RED}Script not found: $script${NC}"
        return 1
    fi
    
    # Make script executable
    chmod +x "./$script"
    
    # Execute script
    if bash "./$script"; then
        log_message "SUCCESS" "${GREEN}Successfully completed: $script${NC}"
        return 0
    else
        log_message "ERROR" "${RED}Failed to execute: $script (exit code: $?)${NC}"
        return 1
    fi
}

################################################################################
# COLLECT USER INPUTS
################################################################################

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}DEBIAN DESKTOP HARDENING - AUTOMATION${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${YELLOW}This script will automate all hardening steps.${NC}"
echo -e "${YELLOW}Please provide the required information:${NC}"
echo ""

# Collect hostname for log organization
echo -n "Enter hostname for log folder naming: "
read HOSTNAME_INPUT
export log_hostname="$HOSTNAME_INPUT"

# Collect username for multiple scripts (02, 12, 16, 17, 18, 19, 20)
echo -n "Enter the /home username (main user): "
read USERNAME_INPUT
export usernameroot="$USERNAME_INPUT"

# Collect terminal welcome message for script 02
echo -n "Enter Terminal Welcome message [Press Enter if no message]: "
read TMSG_INPUT
export tmsg="$TMSG_INPUT"

# Collect company name for script 33
echo -n "Enter your company name (for banner): "
read COMPANY_INPUT
export company_name="$COMPANY_INPUT"

echo ""
echo -e "${GREEN}Configuration collected successfully!${NC}"
echo ""

# Display collected information for confirmation
echo -e "${YELLOW}Please confirm the following information:${NC}"
echo "  - Hostname (for logs): $log_hostname"
echo "  - Username: $usernameroot"
echo "  - Terminal message: $tmsg"
echo "  - Company name: $company_name"
echo ""
echo -n "Is this information correct? (y/n): "
read CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo -e "${RED}Aborted by user${NC}"
    exit 1
fi

################################################################################
# SCRIPT EXECUTION
################################################################################

log_message "INFO" "Starting automated hardening process"
log_message "INFO" "Hostname (logs): $log_hostname"
log_message "INFO" "Username: $usernameroot"
log_message "INFO" "Company: $company_name"

# Change to script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Counter for statistics
TOTAL_SCRIPTS=0
SUCCESS_COUNT=0
FAILED_COUNT=0
SKIPPED_COUNT=0

# Array of scripts to execute (in order)
# Note: Scripts to exclude are not in this list
SCRIPTS=(
    "00_Resources.sh"
    "01_battery_control.sh"
    "02_bash_aliases.sh"
    "1_secure_cron.sh"
    "2_net-tools.sh"
    "3_libpam.sh"
    "4_common-password.sh"
    "5_login_defs.sh"
    "6_access_conf.sh"
    "7_umask.sh"
    "8_secure_important_files.sh"
    "9_partitions_conf.sh"
    "10_sysctl_conf.sh"
    "11_auditd.sh"
    "12_Sudoers.sh"
    "13_secure_boot.sh"
    "14_disable_ssh.sh"
    "15_aide.sh"
    "16_antivirus.sh"
    "17_firejail.sh"
    "18_stacer.sh"
    "19_virtualbox.sh"
    "20_marktext.sh"
    "22_kde_wallet.sh"
    "23_firewall.sh"
    "24_GetSystemInfos.sh"
    "26_Docker.sh"
    "28_auto_security_updates.sh"
    "29_clean_package_cache.sh"
    "30_Disable_dumps.sh"
    "31_fail2ban.sh"
    "32_accounting_on.sh"
    "33_banner.sh"
    "34_install_rkhunter.sh"
    "35_logging.sh"
    "36_printing.sh"
    "37_Lynis.sh"
    "39_tor_network.sh"
)

################################################################################
# SPECIAL HANDLING FOR SPECIFIC SCRIPTS
################################################################################

# Special handling for script 15_aide.sh
handle_aide_prerequisites() {
    log_message "INFO" "${YELLOW}Preparing prerequisites for AIDE...${NC}"
    
    # Ensure aide package is installed before initialization
    log_message "INFO" "Installing AIDE package..."
    apt-get install -y aide
    
    # Create directory if it doesn't exist
    mkdir -p /var/lib/aide
    
    # Wait for package configuration to complete
    sleep 2
    
    log_message "INFO" "AIDE prerequisites ready"
}

# Function to modify script with stdin input for automatic execution
prepare_script_for_automation() {
    local script=$1
    local script_name="${script%.sh}"
    local log_file="${script_name}.log"
    
    # 00_Resources.sh ne crée pas de fichier log
    if [ "$script" = "00_Resources.sh" ]; then
        log_message "INFO" "Executing $script (no log file)"
        bash "./$script"
        return $?
    fi
    
    # Les scripts créent déjà leur propre fichier log via exec
    log_message "INFO" "Log file: $log_file"
    
    case "$script" in
        "02_bash_aliases.sh")
            # Script reads usernameroot and tmsg, which are now exported
            log_message "INFO" "Providing inputs for 02_bash_aliases.sh"
            (echo "$usernameroot"; echo "$tmsg") | bash "./$script"
            return $?
            ;;
        "12_Sudoers.sh")
            # Script reads usernameroot, which is now exported
            log_message "INFO" "Providing inputs for 12_Sudoers.sh"
            echo "$usernameroot" | bash "./$script"
            return $?
            ;;
        "16_antivirus.sh")
            # Script reads usernameroot, which is now exported
            log_message "INFO" "Providing inputs for 16_antivirus.sh"
            echo "$usernameroot" | bash "./$script"
            return $?
            ;;
        "17_firejail.sh")
            # Script reads usernameroot, which is now exported
            log_message "INFO" "Providing inputs for 17_firejail.sh"
            echo "$usernameroot" | bash "./$script"
            return $?
            ;;
        "18_stacer.sh")
            # Script reads usernameroot, which is now exported
            log_message "INFO" "Providing inputs for 18_stacer.sh"
            echo "$usernameroot" | bash "./$script"
            return $?
            ;;
        "19_virtualbox.sh")
            # Script reads usernameroot, which is now exported
            log_message "INFO" "Providing inputs for 19_virtualbox.sh"
            echo "$usernameroot" | bash "./$script"
            return $?
            ;;
        "20_marktext.sh")
            # Script reads usernameroot, which is now exported
            log_message "INFO" "Providing inputs for 20_marktext.sh"
            echo "$usernameroot" | bash "./$script"
            return $?
            ;;
        "33_banner.sh")
            # Script reads company_name, which is now exported
            log_message "INFO" "Providing inputs for 33_banner.sh"
            echo "$company_name" | bash "./$script"
            return $?
            ;;
        "28_auto_security_updates.sh")
            # dpkg-reconfigure may ask for confirmation
            log_message "INFO" "Handling dpkg-reconfigure for unattended-upgrades"
            export DEBIAN_FRONTEND=noninteractive
            bash "./$script"
            unset DEBIAN_FRONTEND
            return $?
            ;;
        "23_firewall.sh")
            # ufw enable may ask for confirmation
            log_message "INFO" "Handling ufw enable confirmation"
            yes | bash "./$script"
            return $?
            ;;
        *)
            # Default execution (scripts create their own log files)
            bash "./$script"
            return $?
            ;;
    esac
}

################################################################################
# MAIN EXECUTION LOOP
################################################################################

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}EXECUTING HARDENING SCRIPTS${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

for script in "${SCRIPTS[@]}"; do
    TOTAL_SCRIPTS=$((TOTAL_SCRIPTS + 1))
    
    echo ""
    echo -e "${BLUE}────────────────────────────────────────${NC}"
    log_message "INFO" "Script $TOTAL_SCRIPTS/${#SCRIPTS[@]}: $script"
    
    # Skip if script doesn't exist
    if [ ! -f "./$script" ]; then
        log_message "WARNING" "${YELLOW}Script not found, skipping: $script${NC}"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        continue
    fi
    
    # Make script executable
    chmod +x "./$script" 2>/dev/null
    
    # Special handling for AIDE
    if [ "$script" = "15_aide.sh" ]; then
        handle_aide_prerequisites
    fi
    
    # Execute script with appropriate handling
    if prepare_script_for_automation "$script"; then
        log_message "SUCCESS" "${GREEN}✓ Successfully completed: $script${NC}"
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    else
        EXIT_CODE=$?
        log_message "ERROR" "${RED}✗ Failed: $script (exit code: $EXIT_CODE)${NC}"
        FAILED_COUNT=$((FAILED_COUNT + 1))
        
        # Ask user if they want to continue
        echo ""
        echo -e "${YELLOW}A script has failed. Do you want to continue with the remaining scripts?${NC}"
        echo -n "Continue? (y/n): "
        read CONTINUE
        
        if [ "$CONTINUE" != "y" ] && [ "$CONTINUE" != "Y" ]; then
            log_message "INFO" "Automation stopped by user after failure"
            break
        fi
    fi
done

################################################################################
# FINAL SUMMARY
################################################################################

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}AUTOMATION COMPLETE${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

log_message "INFO" "Automation process completed"
log_message "INFO" "Total scripts: $TOTAL_SCRIPTS"
log_message "INFO" "Successful: $SUCCESS_COUNT"
log_message "INFO" "Failed: $FAILED_COUNT"
log_message "INFO" "Skipped: $SKIPPED_COUNT"

echo -e "${GREEN}✓ Successful:${NC} $SUCCESS_COUNT"
echo -e "${RED}✗ Failed:${NC} $FAILED_COUNT"
echo -e "${YELLOW}⊘ Skipped:${NC} $SKIPPED_COUNT"
echo ""
echo -e "${BLUE}Full log available at: $AUTOMATION_LOG${NC}"
echo ""

# List excluded scripts for reference
echo -e "${YELLOW}Note: The following scripts were intentionally excluded:${NC}"
echo "  - 00_Default_hardening.sh"
echo "  - 11_auditd_option.sh"
echo "  - 21_tor_browser.sh"
echo "  - 25_samba.sh"
echo "  - 26_Docker_insecure.sh"
echo "  - 27_MS_teams_via_Snapd.sh"
echo ""

################################################################################
# ORGANIZE AND COMPRESS LOGS
################################################################################

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}ORGANIZING LOG FILES${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

LOG_DIR="logs_${log_hostname}"
log_message "INFO" "Creating log directory: $LOG_DIR"

# Create log directory
mkdir -p "$LOG_DIR"

# Copy all .log files to the directory (except the automation log)
log_message "INFO" "Copying individual script logs to $LOG_DIR"
LOG_COUNT=0
for logfile in *.log; do
    if [ -f "$logfile" ] && [ "$logfile" != "$(basename $AUTOMATION_LOG)" ]; then
        cp "$logfile" "$LOG_DIR/"
        LOG_COUNT=$((LOG_COUNT + 1))
    fi
done

# Also copy the automation log
cp "$AUTOMATION_LOG" "$LOG_DIR/"
log_message "INFO" "Copied automation log to $LOG_DIR"

# Change ownership of the directory and all files inside
log_message "INFO" "Changing ownership to $usernameroot:$usernameroot"
chown -R "$usernameroot:$usernameroot" "$LOG_DIR"

# Create ZIP archive
ZIP_FILE="${LOG_DIR}.zip"
log_message "INFO" "Creating ZIP archive: $ZIP_FILE"

if command -v zip &> /dev/null; then
    zip -r "$ZIP_FILE" "$LOG_DIR" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        log_message "SUCCESS" "${GREEN}✓ ZIP archive created successfully${NC}"
        
        # Change ownership of the ZIP file
        chown "$usernameroot:$usernameroot" "$ZIP_FILE"
        
        echo ""
        echo -e "${GREEN}✓ Log files organized:${NC}"
        echo -e "  Directory: ${BLUE}$LOG_DIR${NC}"
        echo -e "  Log files: ${BLUE}$LOG_COUNT${NC} individual scripts + automation log"
        echo -e "  ZIP archive: ${BLUE}$ZIP_FILE${NC}"
        echo -e "  Owner: ${BLUE}$usernameroot${NC}"
    else
        log_message "ERROR" "${RED}Failed to create ZIP archive${NC}"
    fi
else
    log_message "WARNING" "${YELLOW}zip command not found, skipping compression${NC}"
    echo -e "${YELLOW}Install zip package: apt-get install zip${NC}"
fi

echo ""

# Copy update_upgrade.sh to Desktop
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}FINAL SETUP${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

if [ -f "./update_upgrade.sh" ]; then
    DESKTOP_PATH="/home/$usernameroot/Desktop"
    if [ -d "$DESKTOP_PATH" ]; then
        log_message "INFO" "Copying update_upgrade.sh to Desktop"
        cp "./update_upgrade.sh" "$DESKTOP_PATH/"
        chmod +x "$DESKTOP_PATH/update_upgrade.sh"
        chown "$usernameroot:$usernameroot" "$DESKTOP_PATH/update_upgrade.sh"
        echo -e "${GREEN}✓ update_upgrade.sh copied to Desktop${NC}"
    else
        log_message "WARNING" "Desktop directory not found: $DESKTOP_PATH"
    fi
else
    log_message "WARNING" "update_upgrade.sh not found"
fi

echo ""

if [ $FAILED_COUNT -eq 0 ]; then
    echo -e "${GREEN}All scripts executed successfully!${NC}"
    exit 0
else
    echo -e "${RED}Some scripts failed. Please review the log files for details.${NC}"
    exit 1
fi
