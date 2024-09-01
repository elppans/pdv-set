#!/bin/bash
# shellcheck disable=SC1078,SC1079,SC2140

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

export IP_DIR
export IP_FILE
export IP_OK_FILE
export IP_OFF_FILE

mkdir -p "$IP_DIR"

# Se o parâmetro foi fornecido, atribui-o à variável 'user'
user="$1"
passwd="$2"
export user
export passwd

# Executar comandos via SSH, usando IP atribuido ao arquivo ip_OK.txt
# shellcheck disable=SC2013
for IP in $(cat "$IP_OK_FILE"); do

    echo "$IP" &&
        sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no "$user"@"$IP" \
            "
source /etc/environment
echo ""$passwd"" | sudo -S $Z_MOUNT 2>/dev/null
mount | grep path
echo ""$passwd"" | sudo -S find /Zanthus -name ECFRECEB.CFG 
# Procurar e remover com find em /Zanthus o arquivo ECFRECEB.CFG mantendo o do diretório /Zanthus/Zeus/pdvJava
# Procurar e remover também, ECFRECEB.CFG.OLD
echo ""$passwd"" | sudo -S find /Zanthus -path /Zanthus/Zeus/pdvJava -prune -o \( -name "ECFRECEB.CFG" -o -name "ECFRECEB.CFG.OLD" \) -exec rm {} \; 2>/dev/null
echo ""$passwd"" | sudo -S rm -rf /opt/pdv_e1update 2> /dev/null
echo ""$passwd"" | sudo -S git clone https://github.com/elppans/pdv-Elgini9E1x64.git /opt/pdv_e1update
cd /opt/pdv_e1update
echo ""$passwd"" | sudo -S ./set_Elgini9E1x64.sh
cat /etc/canoalinux-release
cat /Zanthus/Zeus/pdvJava/ECFRECEB.CFG
cat /Zanthus/Zeus/pdvJava/EMUL.INI
ls -l /Zanthus/Zeus/lib_u64/libE1_Impressora*
cd /opt
echo ""$passwd"" | sudo -S rm -rf /opt/pdv_e1update &>>/dev/null
echo ""
# echo ""$passwd"" | date | sudo -S tee /Zanthus/Zeus/update.txt 
"
done
