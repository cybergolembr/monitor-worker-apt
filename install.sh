#!/bin/bash
# install.sh - CyberGolem Monitor Worker Installer

set -e

# Cores para o output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== CyberGolem Monitor Worker Installer ===${NC}"

# Verificar se é root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Erro: Por favor, execute como root (sudo).${NC}"
  exit 1
fi

# 1. Adicionar chave GPG
echo -e "${BLUE}[1/3] Adicionando chave GPG...${NC}"
curl -sS https://cybergolembr.github.io/monitor-worker-apt/public.key | gpg --dearmor -o /usr/share/keyrings/monitor-worker-archive-keyring.gpg --overwrite

# 2. Adicionar Repositório
echo -e "${BLUE}[2/3] Configurando repositório APT...${NC}"
echo "deb [signed-by=/usr/share/keyrings/monitor-worker-archive-keyring.gpg] https://cybergolembr.github.io/monitor-worker-apt/ stable main" | tee /etc/apt/sources.list.d/monitor-worker.list > /dev/null

# 3. Instalar
echo -e "${BLUE}[3/3] Instalando monitor-worker...${NC}"
apt update
apt install -y monitor-worker

echo -e "${GREEN}✓ Instalação concluída com sucesso!${NC}"
echo -e "O worker já está rodando. Use 'systemctl status monitor-worker' para verificar."
