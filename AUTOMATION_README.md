# Script d'Automatisation - Debian Desktop Hardening

## Description

Le script `run_all_hardening.sh` automatise l'exécution de tous les scripts de durcissement Debian dans le bon ordre. Il gère automatiquement les prompts utilisateur et vérifie la bonne exécution de chaque script.

## Prérequis

- Système Debian (Bullseye/Bookworm)
- Droits root/sudo
- Tous les scripts de durcissement présents dans le répertoire
- Fichiers de configuration requis (common-password, login.defs, access.conf, etc.)
- Fichiers téléchargés via 00_Resources.sh si nécessaire

## Scripts Exclus

Les scripts suivants ne sont **PAS** exécutés par l'automation :

- `00_Default_hardening.sh`
- `11_auditd_option.sh`
- `21_tor_browser.sh`
- `25_samba.sh`
- `26_Docker_insecure.sh`
- `27_MS_teams_via_Snapd.sh`

## Scripts Inclus (dans l'ordre)

1. `00_Resources.sh` - Téléchargement des ressources externes
2. `01_battery_control.sh` - Vérification de la batterie
3. `02_bash_aliases.sh` - Configuration du message de bienvenue terminal
4. `1_secure_cron.sh` - Sécurisation des tâches cron
5. `2_net-tools.sh` - Installation des outils réseau
6. `3_libpam.sh` - Installation des bibliothèques PAM
7. `4_common-password.sh` - Configuration des mots de passe
8. `5_login_defs.sh` - Configuration des logins
9. `6_access_conf.sh` - Configuration des accès
10. `7_umask.sh` - Configuration umask
11. `8_secure_important_files.sh` - Sécurisation des fichiers importants
12. `9_partitions_conf.sh` - Configuration des partitions
13. `10_sysctl_conf.sh` - Configuration sysctl
14. `11_auditd.sh` - Installation et configuration d'auditd
15. `12_Sudoers.sh` - Configuration sudoers
16. `13_secure_boot.sh` - Sécurisation du démarrage
17. `14_disable_ssh.sh` - Configuration SSH
18. `15_aide.sh` - Installation et configuration AIDE (IDS)
19. `16_antivirus.sh` - Installation et configuration ClamAV
20. `17_firejail.sh` - Installation et configuration Firejail
21. `18_stacer.sh` - Installation Stacer
22. `19_virtualbox.sh` - Installation VirtualBox
23. `20_marktext.sh` - Installation MarkText
24. `22_kde_wallet.sh` - Configuration KDE Wallet
25. `23_firewall.sh` - Configuration du pare-feu (UFW)
26. `24_GetSystemInfos.sh` - Récupération des informations système
27. `26_Docker.sh` - Installation Docker
28. `28_auto_security_updates.sh` - Configuration des mises à jour automatiques
29. `29_clean_package_cache.sh` - Nettoyage du cache des paquets
30. `30_Disable_dumps.sh` - Désactivation des core dumps
31. `31_fail2ban.sh` - Installation et configuration Fail2ban
32. `32_accounting_on.sh` - Activation de la comptabilité des processus
33. `33_banner.sh` - Configuration du banner de connexion
34. `34_install_rkhunter.sh` - Installation de Rootkit Hunter
35. `35_logging.sh` - Configuration du logging
36. `36_printing.sh` - Configuration de CUPS
37. `37_Lynis.sh` - Installation et exécution de Lynis
38. `39_tor_network.sh` - Installation du réseau Tor

## Utilisation

### 1. Préparation

Assurez-vous que tous les fichiers sont présents dans le répertoire :

```bash
cd /home/pupu/Documents/debiandesktop-hardening
ls -la
```

Vérifiez la présence des fichiers de configuration nécessaires :
- `common-password`
- `login.defs`
- `access.conf`
- `*.rules` (fichiers de règles audit)
- `*.desktop` (fichiers de raccourcis)

### 2. Exécution

Rendre le script exécutable (si ce n'est pas déjà fait) :

```bash
chmod +x run_all_hardening.sh
```

Exécuter le script en tant que root :

```bash
sudo ./run_all_hardening.sh
```

### 3. Informations demandées

Le script vous demandera les informations suivantes au début :

1. **Username** : Le nom d'utilisateur principal dans /home
   - Utilisé par les scripts : 02, 12, 16, 17, 18, 19, 20
   - Exemple : `pupu`

2. **Terminal Welcome Message** : Message de bienvenue dans le terminal (optionnel)
   - Utilisé par le script : 02
   - Exemple : `Bienvenue sur votre système sécurisé`

3. **Company Name** : Nom de votre entreprise pour le banner
   - Utilisé par le script : 33
   - Exemple : `Angrybee.tech`

### 4. Confirmation

Après avoir saisi ces informations, le script affichera un résumé et demandera confirmation avant de commencer l'exécution.

## Fonctionnalités

### Gestion automatique des prompts

Le script gère automatiquement :
- Les demandes de confirmation apt/apt-get (y/n)
- Les prompts de saisie utilisateur
- Les confirmations dpkg-reconfigure
- Les confirmations UFW

### Gestion spéciale pour AIDE

Le script 15_aide.sh nécessite que la base de données AIDE soit créée. L'automation :
1. Crée le répertoire `/var/lib/aide` si nécessaire
2. Laisse le script AIDE initialiser la base de données

### Logs détaillés

- Chaque script génère son propre fichier log (ex: `01_battery_control.log`)
- L'automation génère un log global : `automation_YYYYMMDD_HHMMSS.log`
- Les messages sont horodatés et colorés dans le terminal

### Gestion des erreurs

- Si un script échoue, le script d'automation demande si vous souhaitez continuer
- Un résumé final affiche le nombre de scripts réussis/échoués/ignorés
- Code de sortie : 0 si succès, 1 si des échecs

## Résumé Final

À la fin de l'exécution, vous verrez :

```
========================================
AUTOMATION COMPLETE
========================================

✓ Successful: XX
✗ Failed: XX
⊘ Skipped: XX

Full log available at: automation_YYYYMMDD_HHMMSS.log
```

## Variables d'environnement exportées

Le script exporte les variables suivantes pour les scripts enfants :
- `usernameroot` : Nom d'utilisateur principal
- `tmsg` : Message de bienvenue terminal
- `company_name` : Nom de l'entreprise

## Dépannage

### Problème : Script non trouvé
**Solution** : Vérifiez que tous les scripts sont bien présents dans le répertoire

### Problème : Permission denied
**Solution** : Exécutez avec sudo : `sudo ./run_all_hardening.sh`

### Problème : Échec du script AIDE
**Solution** : Vérifiez que le répertoire `/var/lib/aide` est accessible et que le paquet aide est installable

### Problème : Échec installation VirtualBox/MarkText
**Solution** : Vérifiez que les fichiers .deb ont été téléchargés par 00_Resources.sh

## Notes importantes

1. **Sauvegardes** : Les scripts créent des sauvegardes des fichiers de configuration (*.save)
2. **Redémarrage** : Certains changements peuvent nécessiter un redémarrage du système
3. **Ordre d'exécution** : L'ordre des scripts est important, ne pas modifier
4. **Temps d'exécution** : L'exécution complète peut prendre 30-60 minutes selon la connexion internet

## Licence

Apache License 2.0 - Copyright 2022-2024 Angrybee.tech (https://angrybee.tech)
