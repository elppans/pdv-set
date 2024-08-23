#!/bin/bash

IP_DIR="$HOME/.ip"
IP_FILE="$IP_DIR/ip.txt"
IP_OK_FILE="$IP_DIR/ip_ok.txt"
IP_OFF_FILE="$IP_DIR/ip_off.txt"

mkdir -p "$IP_DIR"

# Função para verificar se o arquivo ip.txt existe
check_ip_file_exists() {
    if [ ! -f "$IP_FILE" ]; then
        echo "Erro: O arquivo $IP_FILE não existe."
        exit 1
    fi
}

# Executa função de verificação do arquivo ip.txt
check_ip_file_exists

rm -rf "$IP_OK_FILE" >> /dev/null
rm -rf "$IP_OFF_FILE" >> /dev/null

# shellcheck disable=SC2013
for IP in $(cat "$IP_FILE"); do
    if ping -c 1 "$IP" >>/dev/null; then
        echo "$IP" OK
        echo "$IP" >>"$IP_OK_FILE"
    else
        echo "$IP OFF"
        echo "$IP" >>"$IP_OFF_FILE"
    fi
done
