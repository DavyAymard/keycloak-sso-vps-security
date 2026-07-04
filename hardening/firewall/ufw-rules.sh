#!/usr/bin/env bash
# Configure un pare-feu ufw minimal pour ce lab : deny par défaut, SSH + HTTPS
# Keycloak autorisés uniquement. À exécuter avec sudo sur le VPS.
#
# Usage : sudo ./ufw-rules.sh

set -euo pipefail

ufw default deny incoming
ufw default allow outgoing

ufw allow OpenSSH
ufw allow 8443/tcp comment 'Keycloak HTTPS'

ufw --force enable
ufw status verbose
