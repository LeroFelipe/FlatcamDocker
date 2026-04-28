# ⚡ FlatCAM Dockerized

Este repositório fornece uma solução isolada para rodar o **FlatCAM** utilizando Docker e Docker Compose. O objetivo é facilitar o uso da ferramenta sem a necessidade de instalar dependências complexas (Python 2/3, Qt, etc.) diretamente no seu sistema operacional.

---

## 🇧🇷 Português

### 🐧 Compatibilidade
Testado com sucesso em:
* **Fedora** (KDE Plasma)
* **Arch Linux** (KDE Plasma)
* Suporte a **X11** e **Wayland** (via XWayland)

### 🚀 Como Iniciar
O projeto utiliza um script de entrada (`flatcam.sh`) que configura as permissões de vídeo e mapeia o usuário automaticamente.

1. **Garanta permissão de execução:**
   ```bash
   chmod +x flatcam.sh
   ```
2. **Inicie o container:**
   ```bash
   ./flatcam.sh
   ```

> [!IMPORTANT]
> **Por que usar o script e não o comando `docker compose up` diretamente?**
> Se você rodar apenas o comando do Docker, dois problemas ocorrerão:
> 1. **Erro de Display:** O Docker não terá permissão para abrir janelas no seu monitor (X11 permission denied).
> 2. **Permissões de Arquivo:** Arquivos salvos pertencerão ao `root`, impedindo que você os edite ou delete no seu computador host.
> O script `flatcam.sh` resolve isso configurando o `xhost` e mapeando seu `UID/GID` em tempo de execução.

### 🛠️ Detalhes Técnicos
* **Gerenciamento de Usuário:** O script exporta `MY_UID` e `MY_GID` para que os arquivos criados no container tenham o mesmo dono do usuário atual.
* **Estrutura de Volumes:**
    * `./projects` ➔ `/app/projects`: Para seus arquivos Gerber/Excellon.
    * `./config` ➔ `/home/developer`: Salva suas preferências de forma persistente.
* **Gráficos:** Compartilha o socket do X11 (`/tmp/.X11-unix`) e gerencia o acesso via `xhost`.

---

## 🇺🇸 English

### 🐧 Compatibility
Successfully tested on:
* **Fedora** (KDE Plasma)
* **Arch Linux** (KDE Plasma)
* **Ubuntu 24.04 LTS** (Noble Numbat)
* **X11** and **Wayland** (via XWayland) support

### 🚀 Getting Started
The project uses an entry script (`flatcam.sh`) that handles video permissions and automatic user mapping.

1. **Grant execution permission:**
   ```bash
   chmod +x flatcam.sh
   ```
2. **Start the container:**
   ```bash
   ./flatcam.sh
   ```

> [!IMPORTANT]
> **Do not run `docker compose up` directly.**
> Running the command without the script will result in:
> 1. **Display Connection Errors:** The container will be denied access to the X server.
> 2. **File Permission Issues:** Files created inside the container will be owned by `root`.
> The `flatcam.sh` script handles `xhost` authorization and exports your `UID/GID` to ensure everything works smoothly.

### 🛠️ Technical Details
* **User Management:** The script exports your current user's `MY_UID` and `MY_GID` to ensure files saved in volumes belong to you on the host machine.
* **Volume Structure:**
    * `./projects` ➔ `/app/projects`: Place your Gerber and Excellon files here.
    * `./config` ➔ `/home/developer`: Persistently saves your preferences and tool libraries.
* **Graphics & Display:** Shares the X11 socket (`/tmp/.X11-unix`) and uses `xhost +local:docker` for GUI rendering. Access is automatically revoked when the script exits.

---

## 📁 Estrutura do Repositório / Repo Structure
* `flatcam.sh`: Automation script for permissions and startup.
* `docker-compose.yml`: Service definition and volume mapping.
* `Dockerfile`: Image recipe with FlatCAM dependencies.

---
**Author:** Lérisson Felipe Pereira
