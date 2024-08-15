#!/bin/bash

IP_FILE="ip.txt"

# Função para verificar se o arquivo ip.txt existe
check_ip_file_exists() {
    if [ ! -f "$IP_FILE" ]; then
        echo "Erro: O arquivo $IP_FILE não existe."
        exit 1
    fi
}

# Executa função de verificação do arquivo ip.txt
check_ip_file_exists

rm -rf ip_OK.txt >> /dev/null
rm -rf ip_OFF.txt >> /dev/null

# shellcheck disable=SC2013
for IP in $(cat ip.txt); do
    if ping -c 1 "$IP" >>/dev/null; then
        echo "$IP" OK
        echo "$IP" >>ip_OK.txt
    else
        echo "$IP OFF"
        echo "$IP" >>ip_OFF.txt
    fi
done
