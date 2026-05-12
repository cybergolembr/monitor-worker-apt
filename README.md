# CyberGolem Monitor Worker Repository

Este é o repositório oficial de pacotes para o **Monitor Worker** da CyberGolem.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Linux](https://img.shields.io/badge/Platform-Linux-lightgrey.svg)](https://www.linux.org/)

---

## Instalação Rápida (One-Liner)

Se você estiver em um sistema baseado em Debian ou Ubuntu, pode instalar o worker com o seguinte comando:

```bash
curl -sSL https://cybergolembr.github.io/monitor-worker-apt/install.sh | sudo bash
```

---

## Instalação Manual

Se preferir fazer o passo a passo manualmente:

### 1. Adicionar Chave GPG
Isso garante que você está instalando pacotes assinados e seguros.

```bash
curl -sS https://cybergolembr.github.io/monitor-worker-apt/public.key | sudo gpg --dearmor -o /usr/share/keyrings/monitor-worker-archive-keyring.gpg
``` 

### 2. Adicionar o Repositório
Adicione o repositório da CyberGolem às suas fontes de software.

```bash
echo "deb [signed-by=/usr/share/keyrings/monitor-worker-archive-keyring.gpg] https://cybergolembr.github.io/monitor-worker-apt/ stable main" | sudo tee /etc/apt/sources.list.d/monitor-worker.list
```

### 3. Instalar o Worker
Atualize o cache do APT e instale o pacote.

```bash
sudo apt update
sudo apt install monitor-worker
```

---

## Como Usar

O worker é instalado como um serviço do sistema (`systemd`).

**Verificar status:**
```bash
systemctl status monitor-worker
```

**Iniciar o serviço:**
```bash
sudo systemctl start monitor-worker
```

**Parar o serviço:**
```bash
sudo systemctl stop monitor-worker
```

**Ver os logs:**
```bash
journalctl -u monitor-worker -f
```

---

## Suporte
Se encontrar algum problema, entre em contato em [brunobuzzeto.dev@gmail.com](mailto:brunobuzzeto.dev@gmail.com).

CyberGolem © 2026
