#!/bin/bash
# shellcheck disable=SC1078,SC1079,SC2140

# Verifica se o primeiro parâmetro foi fornecido
if [ -z "$1" ]; then
    echo "Você não forneceu nenhum valor. Por favor, insira um valor para o usuario."
    exit 1
fi
# Verifica se o segundo parâmetro foi fornecido
if [ -z "$2" ]; then
    echo "Você não forneceu nenhum valor. Por favor, insira um valor para a senha."
    exit 1
fi

# Variáveis para o ambiente
IP_DIR="$HOME/.ip"
IP_FILE="$IP_DIR/ip.txt"
IP_OK_FILE="$IP_DIR/ip_ok.txt"
IP_OFF_FILE="$IP_DIR/ip_off.txt"

# Exportar variáveis do ambiente
export IP_DIR
export IP_FILE
export IP_OK_FILE
export IP_OFF_FILE

# cria diretório de configuração, se não existir
mkdir -p "$IP_DIR"

# Se o parâmetro foi fornecido, atribui-o à variável correspondente
user="$1"
passwd="$2"
export user
export passwd

# Atribui um IP usando o arquivo da variável "IP_OK_FILE"
# shellcheck disable=SC2013
for IP in $(cat "$IP_OK_FILE"); do
    # Faz um Scan dos IPs fornecidos e adiciona na lista de chaves, se necessário
    ./ssh-keyscan.sh "$IP" &>>/dev/null
    # Executar comandos via SSH, usando IP atribuido ao arquivo da variável "IP_OK_FILE"
    echo "$IP"
    sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no "$user"@"$IP" \
        "
source /etc/environment
echo ""$passwd"" | sudo -S $Z_MOUNT 2>/dev/null
mount | grep path
echo ""$passwd"" | sudo -S find /Zanthus -name ECFRECEB.CFG 
# Procurar e remover com find em /Zanthus o arquivo ECFRECEB.CFG mantendo o do diretório /Zanthus/Zeus/pdvJava
# No mesmo comando, procurar e remover também, ECFRECEB.CFG.OLD
echo ""$passwd"" | sudo -S find /Zanthus -path /Zanthus/Zeus/pdvJava -prune -o \( -name "ECFRECEB.CFG" -o -name "ECFRECEB.CFG.OLD" \) -exec rm {} \; 2>/dev/null
# Remover se existir, diretório de trabalho "git", clonar novamente e então, executar a configuração.
echo ""$passwd"" | sudo -S rm -rf /opt/pdv_e1update 2> /dev/null
echo ""$passwd"" | sudo -S git clone https://github.com/elppans/pdv-Elgini9E1x64.git /opt/pdv_e1update
cd /opt/pdv_e1update
echo ""$passwd"" | sudo -S ./set_Elgini9E1x64.sh
echo ""
echo 'Versão do PDV:'
cat /etc/canoalinux-release
echo 'Configuração do ECFRECEB.CFG:'
cat /Zanthus/Zeus/pdvJava/ECFRECEB.CFG
echo 'Configuração do EMUL.INI:'
cat /Zanthus/Zeus/pdvJava/EMUL.INI
echo 'Biblioteca libE1...:'
ls -l /Zanthus/Zeus/lib_u64/libE1_Impressora*
cd /opt
# Remoção do diretório de trabalho "git"
echo ""$passwd"" | sudo -S rm -rf /opt/pdv_e1update &>>/dev/null
echo ""
# echo ""$passwd"" | date | sudo -S tee /Zanthus/Zeus/update.txt 
"
done
