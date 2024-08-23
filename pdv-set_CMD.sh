#!/bin/bash
# shellcheck disable=SC1078,SC1079,SC2013,SC2140

# Verifica se o primeiro parâmetro foi fornecido
if [ -z "$1" ]; then
    echo "Você não forneceu nenhum valor. Por favor, insira um valor para o usuario."
    exit 1
fi

if [ -z "$2" ]; then
    echo "Você não forneceu nenhum valor. Por favor, insira um valor para a senha."
    exit 1
fi

if [ -z "$3" ]; then
    echo "Você não forneceu nenhum valor. Por favor, insira um valor para o arquivo."
    exit 1
fi

# Se o parâmetro foi fornecido, atribui-o à variável 'user'
user="$1"
passwd="$2"
file="cat $3"
export user
export passwd
export file

# Executar comandos via SSH, usando IP atribuido ao arquivo ip_OK.txt
for IP in $(cat ip_OK.txt); do
    ./ssh-keyscan.sh "$IP" &>>/dev/null
    echo "$IP"
    sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no "$user"@"$IP" \
        "
    ""${file}""
"
done
