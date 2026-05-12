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
echo -e "${BLUE}[1/4] Adicionando chave GPG...${NC}"
curl -sS https://cybergolembr.github.io/monitor-worker-apt/public.key | gpg --dearmor -o /usr/share/keyrings/monitor-worker-archive-keyring.gpg --overwrite

# 2. Adicionar Repositório
echo -e "${BLUE}[2/4] Configurando repositório APT...${NC}"
echo "deb [signed-by=/usr/share/keyrings/monitor-worker-archive-keyring.gpg] https://cybergolembr.github.io/monitor-worker-apt/ stable main" | tee /etc/apt/sources.list.d/monitor-worker.list > /dev/null

# 3. Coletar dados de Onboarding
echo -e "${BLUE}[3/4] Configuração de Onboarding...${NC}"

if [ -f /etc/monitor-worker/config.env ]; then
  echo -e "${GREEN}✓ Configuração já existente encontrada em /etc/monitor-worker/config.env. Pulando onboarding...${NC}"
else
  echo -e "Obtenha as credenciais abaixo na plataforma CyberGolem (Painel do Worker)."

  read -p "Digite a URL do Servidor (ex: https://api.cybergolem.io): " SERVER_URL
  read -p "Digite a sua API Key (Token): " API_KEY
  read -p "Digite o ID da Instância: " INSTANCE_ID
  read -p "Digite o ID do Log Stream (opcional): " INSTANCE_LOGSTREAM_ID
  read -p "Caminhos de Log para monitorar (ex: /var/log/syslog,/var/log/auth.log): " MONITOR_LOG_PATHS

  # Criar diretório de config se não existir
  mkdir -p /etc/monitor-worker

  # Gerar o arquivo de ambiente
  cat <<EOF > /etc/monitor-worker/config.env
SERVER_URL=$SERVER_URL
API_KEY=$API_KEY
INSTANCE_ID=$INSTANCE_ID
INSTANCE_LOGSTREAM_ID=$INSTANCE_LOGSTREAM_ID
MONITOR_LOG_PATHS=$MONITOR_LOG_PATHS
EOF

  chmod 600 /etc/monitor-worker/config.env
fi

# 4. Instalar
echo -e "${BLUE}[4/4] Instalando monitor-worker...${NC}"
apt update
apt install -y monitor-worker

# Reiniciar para garantir que pegou as novas variáveis
systemctl restart monitor-worker

echo -e "${GREEN}✓ Instalação concluída com sucesso!${NC}"
echo -e "O worker já está rodando. Use 'systemctl status monitor-worker' para verificar."
