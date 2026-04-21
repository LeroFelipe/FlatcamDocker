#!/bin/bash

mkdir -p ./projects
mkdir -p ./config

export MY_UID=$(id -u)
export MY_GID=$(id -g)

xhost +local:docker > /dev/null 2>&1

echo "Iniciando FlatCAM..."
echo " - Usuário mapeado: $MY_UID:$MY_GID"
echo " - Salvando projetos em: ./projects"
echo " - Salvando configs em: ./config"

docker compose up

echo "FlatCAM encerrado. Limpando..."
docker compose down > /dev/null 2>&1

xhost -local:docker > /dev/null 2>&1
echo "Permissões de acesso ao display removidas."