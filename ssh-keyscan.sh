#!/bin/bash

# adicionar um host ao arquivo known_hosts sem precisar acessar o servidor.
# Comando para escanear a chave pública do host e adicioná-la ao arquivo known_hosts

#ssh-keyscan -H 10.100.135.83 >> ~/.ssh/known_hosts

#!/bin/bash

IP="$1"
KNOWN_HOSTS_FILE="$HOME/.ssh/known_hosts"

# Verifica se o IP já está no arquivo known_hosts
if ! ssh-keygen -F "$IP" > /dev/null; then
#    echo "O IP $IP já está no arquivo known_hosts."
#else
#    echo "Adicionando o IP $IP ao arquivo known_hosts."
    ssh-keyscan -H "$IP" >> "$KNOWN_HOSTS_FILE"
#    echo "IP $IP adicionado com sucesso."
fi

