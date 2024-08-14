#!/bin/bash

IP="$1"
KNOWN_HOSTS_FILE="$HOME/.ssh/known_hosts"

# Verifica se o IP já está no arquivo known_hosts
if ssh-keygen -F "$IP" > /dev/null; then
    echo "O IP $IP já está no arquivo known_hosts."
else
    echo "Adicionando o IP $IP ao arquivo known_hosts."
    # Usa ssh com StrictHostKeyChecking desativado para adicionar a chave
    ssh -o StrictHostKeyChecking=no -o BatchMode=yes "$IP" exit 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "IP $IP adicionado com sucesso."
    else
        echo "Falha ao adicionar o IP $IP ao arquivo known_hosts."
    fi
fi
