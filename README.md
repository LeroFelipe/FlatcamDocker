# ⚡ FlatCAM Dockerized

Este repositório fornece uma solução isolada para rodar o **FlatCAM** utilizando Docker e Docker Compose. O objetivo é facilitar o uso da ferramenta sem a necessidade de instalar dependências complexas (Python 2/3, Qt, etc.) diretamente no sistema operacional.

## 🐧 Compatibilidade
Testado com sucesso em:
* **Fedora** (KDE Plasma)
* **Arch Linux** (KDE Plasma)
* Suporte a **X11** e **Wayland** (via XWayland)

## 🚀 Como Iniciar

O projeto utiliza um script de entrada (`flatcam.sh`) que configura as permissões de vídeo e mapeia o usuário automaticamente.

1. Garanta que o script tenha permissão de execução:
   chmod +x flatcam.sh

2. Inicie o container:
   ./flatcam.sh

## 🛠️ Detalhes Técnicos

### Gerenciamento de Usuário e Permissões
O script `flatcam.sh` exporta as variáveis `MY_UID` e `MY_GID` do seu usuário atual. Isso garante que qualquer arquivo salvo dentro do container nas pastas de volume pertença ao seu usuário no host, evitando que fiquem bloqueados como "root".

### Estrutura de Volumes
* `./projects`: Mapeado para `/app/projects`. Local para seus arquivos Gerber e Excellon.
* `./config`: Mapeado para o HOME do container (`/home/developer`). Salva suas preferências e bibliotecas de ferramentas de forma persistente.

### Gráficos e Display
O container compartilha o socket do X11 (`/tmp/.X11-unix`) e utiliza o comando `xhost +local:docker` para permitir a renderização da interface gráfica. Ao encerrar o script, o acesso é revogado automaticamente por segurança.

## 📁 Estrutura do Repositório
* `flatcam.sh`: Script de automação de permissões e inicialização.
* `docker-compose.yml`: Definição do serviço e mapeamento de volumes.
* `Dockerfile`: Receita da imagem com as dependências do FlatCAM.
