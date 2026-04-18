xhost +local:docker > /dev/null

docker compose up

echo "FlatCAM encerrado. Removendo permissões de acesso..."
xhost -local:docker > /dev/null