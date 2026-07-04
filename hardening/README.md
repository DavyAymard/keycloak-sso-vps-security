# Durcissement du VPS

Ce dossier regroupe les configurations utilisées pour durcir le VPS Debian/Ubuntu qui héberge
Keycloak, en complément de la sécurisation applicative décrite dans le [README principal](../README.md).

## 1. Pare-feu (`firewall/ufw-rules.sh`)

Politique par défaut « deny » en entrée, seuls SSH et le port HTTPS de Keycloak (8443) sont
ouverts.

```bash
sudo ./firewall/ufw-rules.sh
```

## 2. Durcissement SSH (`ssh/99-hardening.conf`)

Désactive l'authentification par mot de passe et la connexion root directe, limite les
tentatives et coupe les sessions inactives.

```bash
sudo cp ssh/99-hardening.conf /etc/ssh/sshd_config.d/99-hardening.conf
sudo sshd -t                 # valide la syntaxe avant de redémarrer
sudo systemctl restart sshd
```

⚠️ **Avant d'appliquer ce fichier**, s'assurer qu'une clé publique est déjà déployée
(`ssh-copy-id user@vps`) : `PasswordAuthentication no` coupe immédiatement tout accès par mot
de passe.

## 3. Fail2ban (`fail2ban/jail.local`)

Bannit automatiquement les IP après plusieurs échecs d'authentification SSH, avec un temps de
bannissement qui augmente à chaque récidive.

```bash
sudo apt install fail2ban
sudo cp fail2ban/jail.local /etc/fail2ban/jail.local
sudo systemctl restart fail2ban
fail2ban-client status sshd
```

## 4. Mises à jour automatiques

```bash
sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

## Vérification

- `sudo ufw status verbose` : seuls SSH et 8443/tcp doivent apparaître en `ALLOW`.
- `ssh -o PreferredAuthentications=password user@vps` : doit être refusé.
- `fail2ban-client status sshd` : doit lister la jail active.
