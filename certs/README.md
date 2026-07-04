# Certificats TLS

Ce dossier accueille les certificats utilisés par Keycloak pour exposer l'interface en HTTPS
(`configs/docker-compose.yml` monte ce dossier dans le conteneur). Son contenu est ignoré par
git (`.gitignore`) car il s'agit de matériel cryptographique propre à chaque déploiement.

## Génération d'un certificat auto-signé (lab / démo)

```bash
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes \
  -keyout server.key.pem \
  -out server.crt.pem \
  -subj "/CN=<IP_OU_DOMAINE_DU_VPS>"

chmod 644 server.key.pem server.crt.pem
```

- `server.crt.pem` / `server.key.pem` : noms attendus par `KC_HTTPS_CERTIFICATE_FILE` et
  `KC_HTTPS_CERTIFICATE_KEY_FILE` dans `configs/docker-compose.yml`.
- En production, remplacer le certificat auto-signé par un certificat émis par une autorité
  reconnue (ex. Let's Encrypt) pour éviter les avertissements navigateur.
