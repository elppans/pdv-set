#!/bin/bash
# shellcheck disable=SC1078,SC1079,SC2013,SC2140
# shellcheck source=/dev/null

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
for IP in $(cat "$IP_OK_FILE"); do
    ./ssh-keyscan.sh "$IP" &>>/dev/null
    echo "$IP"
    sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no "$user"@"$IP" \
        "
        # Shell/CMD
# Exportar environments
source /Zanthus/Zeus/pdvJava/ECFRECEB.CFG &>>/dev/null

# Verifica se IRQ = i9
if lsusb -d "20d1:7008" > /dev/null; then
# Se IRQ for igual de Elgin i9, faz as configurações necessárias.
    echo "Elgin i9"
    # cmd
    # echo ""$passwd"" | sudo -S sed -i '/FW_FLAGS/s/[0-9]\+/2/' /Zanthus/Zeus/pdvJava/EMUL.INI
    echo ""$passwd"" | sudo -S sed -i '/FW_MODELO_IMPRESSORA/d' /Zanthus/Zeus/pdvJava/EMUL.INI
    echo ""$passwd"" | echo 'FW_MODELO_IMPRESSORA=0' | sudo -S tee -a /Zanthus/Zeus/pdvJava/EMUL.INI >>/dev/null
    echo " "
    grep 'FW_FLAGS' /Zanthus/Zeus/pdvJava/EMUL.INI
    grep 'FW_MODELO_IMPRESSORA' /Zanthus/Zeus/pdvJava/EMUL.INI
	# cmd
# else
# Se IRQ for diferente de Elgin i9, NÃO faz nada!
    # echo " "
fi
        # Shell/CMD
        "
done
