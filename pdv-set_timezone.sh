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
passwd="zanthus"
export user
export passwd

# Executar comandos via SSH, usando IP atribuido ao arquivo ip_OK.txt
for IP in $(cat "$IP_OK_FILE"); do
    ./ssh-keyscan.sh "$IP" &>>/dev/null
    echo "$IP"
    sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no "$user"@"$IP" \
        "
        # Shell/CMD
        echo ""$passwd"" | sudo -S sed -i 's/UTC=no/UTC=yes/' /etc/default/rcS
        echo ""$passwd"" | sudo -S sed -i 's/NTPDATE_USE_NTP_CONF=no/NTPDATE_USE_NTP_CONF=yes/' /etc/default/ntpdate
        echo ""$passwd"" | sudo -S ln -sf /usr/share/zoneinfo/America/Recife /etc/localtime
        echo ""$passwd"" | echo -e 'America/Recife' | sudo -S tee /etc/timezone >> /dev/null
        echo ""$passwd"" | sudo -S dpkg-reconfigure -f noninteractive tzdata
        echo ""$passwd"" | sudo -S hwclock -w
        echo ""$passwd"" | sudo -S timedatectl set-local-rtc 1
        echo ""$passwd"" | sudo -S timedatectl set-ntp 1
        echo ""$passwd"" | sudo -S timedatectl set-timezone  "America/Recife"
        echo ""$passwd"" | sudo -S ntpdate a.ntp.br
        echo ""$passwd"" | sudo -S hwclock -w
        timedatectl
        date
        # Shell/CMD
        "
done
