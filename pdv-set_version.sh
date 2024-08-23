#!/bin/bash
# Script para verificar versão do PDV

# Verifica se o primeiro parâmetro foi fornecido
if [ -z "$1" ]; then
    echo "Você não forneceu nenhum valor. Por favor, insira um valor para o usuario."
    exit 1
fi

if [ -z "$2" ]; then
    echo "Você não forneceu nenhum valor. Por favor, insira um valor para a senha."
    exit 1
fi

IP_DIR="$HOME/.ip"
IP_FILE="$IP_DIR/ip.txt"
IP_OK_FILE="$IP_DIR/ip_ok.txt"
IP_OFF_FILE="$IP_DIR/ip_off.txt"

mkdir -p "$IP_DIR"

# Se o parâmetro foi fornecido, atribui-o à variável 'user'
user="$1"
passwd="$2"
export user
export passwd

# Executar comandos via SSH, usando IP atribuido ao arquivo ip_OK.txt
# shellcheck disable=SC2013
for IP in $(cat "$IP_OK_FILE"); do
        ./ssh-keyscan.sh "$IP"
        # echo "$IP" &&
        sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no "$user"@"$IP" "
        grep VERSION_ID /etc/os-release
        cat /etc/canoalinux-release
        grep biblioteca /Zanthus/Zeus/pdvJava/ECFRECEB.CFG
	cat /Zanthus/Zeus/pdvJava/EMUL.INI
	echo " "
        "
done
