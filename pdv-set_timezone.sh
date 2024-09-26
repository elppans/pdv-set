#!/bin/bash
# shellcheck disable=SC1078,SC1079,SC2013,SC2140
# shellcheck source=/dev/null

# Verifica se o primeiro parâmetro foi fornecido
# if [ -z "$1" ]; then
#     echo "Você não forneceu nenhum valor. Por favor, insira um valor para o usuario."
#     exit 1
# fi

# if [ -z "$2" ]; then
#     echo "Você não forneceu nenhum valor. Por favor, insira um valor para a senha."
#     exit 1
# fi

# Variáveis para o ambiente
IP_DIR="$HOME/.ip"
IP_FILE="$IP_DIR/ip.txt"
IP_OK_FILE="$IP_DIR/ip_ok.txt"
IP_OFF_FILE="$IP_DIR/ip_off.txt"
ssh_options="-o StrictHostKeyChecking=no -t"
localstate="America/Sao_Paulo"

# Exportar variáveis do ambiente
export IP_DIR
export IP_FILE
export IP_OK_FILE
export IP_OFF_FILE
export ssh_options
export localstate

mkdir -p "$IP_DIR"

# Se o parâmetro foi fornecido, atribui-o à variável
passwd="zanthus"
export passwd

# Executar comandos via SSH, usando IP atribuido ao arquivo ip_OK.txt
for IP in $(cat "$IP_OK_FILE"); do
    echo "Ajustando conexão do endereço IP: $IP"
    ./ssh-keyscan.sh "$IP" &>>/dev/null
# Verifica a versão do Ubuntu e executa os comandos apropriados
echo "Verificando usuário ssh..."
pdv_sshuservar() {
if sshpass -p ""$passwd"" ssh ""$ssh_options"" user@"$IP" "lsb_release -r | grep -q '16.04'" &>>/dev/null; then
    user="user"
    export user
elif sshpass -p ""$passwd"" ssh ""$ssh_options"" zanthus@"$IP" "lsb_release -r | grep -q '22.04'"; then
    user="zanthus"
    export user
elif sshpass -p ""$passwd"" ssh ""$ssh_options"" zanthus@"$IP" "lsb_release -r | grep -q '12.04'"; then
    user="zanthus"
    export user
else
    echo "Não foi possível verificar o sistema do IP \"$IP\""
fi
}
    pdv_sshuservar
    sshpass -p "$passwd" ssh ""$ssh_options"" "$user"@"$IP" \
        "
        # Shell/CMD
        echo -e "\nAnalisando versão do PDV..."
        cat /etc/canoalinux-release
        echo "Configurando Timezone..."
        echo ""$passwd"" | sudo -S sed -i 's/UTC=no/UTC=yes/' /etc/default/rcS &>>/dev/null
        echo ""$passwd"" | sudo -S sed -i 's/NTPDATE_USE_NTP_CONF=no/NTPDATE_USE_NTP_CONF=yes/' /etc/default/ntpdate
        echo ""$passwd"" | sudo -S ln -sf /usr/share/zoneinfo/"$localstate" /etc/localtime
        echo ""$passwd"" | echo -e ""$localstate"" | sudo -S tee /etc/timezone >> /dev/null
        echo ""$passwd"" | sudo -S dpkg-reconfigure -f noninteractive tzdata
        echo ""$passwd"" | sudo -S hwclock -w
        echo ""$passwd"" | sudo -S timedatectl set-local-rtc 0
        echo ""$passwd"" | sudo -S timedatectl set-ntp 1
        echo ""$passwd"" | sudo -S timedatectl set-timezone  ""$localstate""
        echo ""$passwd"" | sudo -S ntpdate a.ntp.br b.ntp.br c.ntp.br
        echo ""$passwd"" | sudo -S hwclock -w
        timedatectl
        echo "Hora atual do PDV:"
        date
        echo "Configuração do Timezone finalizada!"
        echo " "
        # Shell/CMD
        "
done
