TEMP_DIR=$HOME/temp_r

if [ ! -z "$1" ]; then

HOST_DES=$1

mkdir -p $TEMP_DIR
	echo "Diretório temporário criado..."

wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O $TEMP_DIR/cloudflared
chmod +x $TEMP_DIR/cloudflared
	echo "Proxy instalado..."

if [ ! -d "$HOME/.local/bin" ]; then
	mkdir -p $HOME/.local/bin
	echo "Diretorio '.local/bin' criado!"
else
	echo "O diretório '.local/bin' já existe! Nenhuma alteração foi feita."
fi

mv $TEMP_DIR/cloudflared $HOME/.local/bin/

if [ ! -d "$HOME/.ssh" ]; then
	mkdir $HOME/.ssh
	echo "Diretorio '.ssh' criado!"
else
    echo "O diretório '.ssh' já existe! Nenhuma alteração foi feita."
fi

echo -e "Host $HOST_DES\n  ProxyCommand /home/$USER/.local/bin/cloudflared access ssh --hostname %h" >> $HOME/.ssh/config
    echo "Proxy configurado!"
rm -rf $TEMP_DIR
    echo "Diretório temporário removido!"
    echo "Configuração concluída."
else
    echo "Faltou o nome do site/host!"
fi