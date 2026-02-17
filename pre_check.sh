#!/bin/bash

################################################################################
# PRE-CHECK SCRIPT - Validation avant automatisation
# Vérifie la présence de tous les fichiers requis
################################################################################

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}PRE-CHECK - Vérification des prérequis${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Counters
MISSING_COUNT=0
PRESENT_COUNT=0

# Function to check file
check_file() {
    local file=$1
    local description=$2
    
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $file - $description"
        PRESENT_COUNT=$((PRESENT_COUNT + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $file - $description ${RED}[MANQUANT]${NC}"
        MISSING_COUNT=$((MISSING_COUNT + 1))
        return 1
    fi
}

# Check if running from correct directory
if [ ! -f "./run_all_hardening.sh" ]; then
    echo -e "${RED}ERREUR: Ce script doit être exécuté depuis le répertoire debiandesktop-hardening${NC}"
    exit 1
fi

echo -e "${YELLOW}Vérification des scripts principaux...${NC}"
echo ""

# Scripts à exécuter
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

# Check each script
for script in "${SCRIPTS[@]}"; do
    check_file "./$script" "Script de configuration"
done

echo ""
echo -e "${YELLOW}Vérification des fichiers de configuration...${NC}"
echo ""

# Configuration files
check_file "./common-password" "Configuration mots de passe PAM"
check_file "./login.defs" "Configuration logins"
check_file "./access.conf" "Configuration accès"

echo ""
echo -e "${YELLOW}Vérification des fichiers de règles audit...${NC}"
echo ""

# Audit rules
check_file "./system-locale.rules" "Règles audit locale"
check_file "./accesses.rules" "Règles audit accès"
check_file "./mounts.rules" "Règles audit montages"
check_file "./scope.rules" "Règles audit scope"
check_file "./root.rules" "Règles audit root"
check_file "./identity.rules" "Règles audit identité"
check_file "./logins.rules" "Règles audit logins"

echo ""
echo -e "${YELLOW}Vérification des fichiers desktop...${NC}"
echo ""

# Desktop files
check_file "./firejail-firefox-esr.desktop" "Raccourci Firejail"
check_file "./stacer.desktop" "Raccourci Stacer"
check_file "./virtualbox.desktop" "Raccourci VirtualBox"
check_file "./marktext.desktop" "Raccourci MarkText"

echo ""
echo -e "${YELLOW}Vérification du script d'automatisation...${NC}"
echo ""

check_file "./run_all_hardening.sh" "Script d'automatisation principal"

# Check if executable
if [ -f "./run_all_hardening.sh" ]; then
    if [ -x "./run_all_hardening.sh" ]; then
        echo -e "${GREEN}✓${NC} run_all_hardening.sh est exécutable"
        PRESENT_COUNT=$((PRESENT_COUNT + 1))
    else
        echo -e "${YELLOW}⚠${NC} run_all_hardening.sh n'est pas exécutable"
        echo -e "   ${YELLOW}Exécutez: chmod +x run_all_hardening.sh${NC}"
    fi
fi

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}RÉSUMÉ${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

echo -e "${GREEN}Fichiers présents:${NC} $PRESENT_COUNT"
echo -e "${RED}Fichiers manquants:${NC} $MISSING_COUNT"
echo ""

# Check for root/sudo
if [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}⚠ Note: Les scripts d'automatisation doivent être exécutés en tant que root${NC}"
    echo -e "   ${YELLOW}Utilisez: sudo ./run_all_hardening.sh${NC}"
    echo ""
fi

# Final verdict
if [ $MISSING_COUNT -eq 0 ]; then
    echo -e "${GREEN}✓ Tous les fichiers requis sont présents!${NC}"
    echo -e "${GREEN}✓ Vous pouvez lancer l'automatisation avec: sudo ./run_all_hardening.sh${NC}"
    echo ""
    exit 0
else
    echo -e "${RED}✗ Il manque $MISSING_COUNT fichier(s)${NC}"
    echo -e "${RED}✗ Veuillez vérifier les fichiers manquants avant de continuer${NC}"
    echo ""
    
    if [ $MISSING_COUNT -le 5 ]; then
        echo -e "${YELLOW}Fichiers manquants les plus critiques:${NC}"
        echo -e "  - Fichiers de règles audit (*.rules)"
        echo -e "  - Fichiers de configuration (common-password, login.defs, access.conf)"
        echo -e "  - Fichiers desktop (*.desktop)"
        echo ""
    fi
    
    exit 1
fi

################################################################################
# NOTES SUPPLÉMENTAIRES
################################################################################
#
# Si des fichiers .deb sont manquants (VirtualBox, MarkText), ils seront
# téléchargés par le script 00_Resources.sh
#
# Fichiers optionnels qui seront créés automatiquement :
#   - /var/lib/aide/aide.db (par le script 15_aide.sh)
#   - Divers fichiers de sauvegarde (*.save)
#   - Fichiers de log (*.log)
#
################################################################################
