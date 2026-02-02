# Keycloak SSO & VPS Security Lab

Ce projet démontre la mise en œuvre d'une infrastructure de gestion des identités et des accès (IAM) robuste sur un environnement VPS Debian. L'objectif est de sécuriser l'accès à des applications tierces via des protocoles standards tout en appliquant des mesures de durcissement (Hardening).

## Réalisations Techniques
- **Orchestration** : Déploiement automatisé via Docker Compose de Keycloak et PostgreSQL.
- **Chiffrement** : Sécurisation des flux via HTTPS avec certificats SSL/TLS .
- **Authentification Forte** : Activation du Multi-Factor Authentication (MFA/OTP) obligatoire pour les comptes à hauts privilèges .
- **Gouvernance** : Isolation des environnements par la création de Realms dédiés .

## Tutoriel de Déploiement

### 1. Préparation du VPS
- Créer un répertoire de travail : `mkdir keycloak-sso-vps-security`.
- Configurer les variables d'environnement dans un fichier `.env` pour isoler les secrets (mots de passe DB et admin) .

### 2. Configuration HTTPS
- Générer les certificats OpenSSL dans un sous-dossier `certs/`.
- Ajuster les permissions Linux (`chmod 644`) pour permettre la lecture des clés par le conteneur Docker .

### 3. Initialisation de la Sécurité
- Accéder à la console via `https://<IP_VPS>:8443`.
- Dans le menu **Authentication**, configurer le flux `browser` pour rendre l'**OTP obligatoire** .
- Créer un Realm de production pour isoler les utilisateurs des applications de l'administration système .

### 4. Validation du Flux OIDC
- Créer un **Client** dans Keycloak avec les URLs de redirection autorisées.
- Tester l'authentification via **OIDC Debugger** pour valider la réception de l'Authorization Code après succès du MFA.