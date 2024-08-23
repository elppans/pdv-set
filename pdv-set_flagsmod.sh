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

# Se o parâmetro foi fornecido, atribui-o à variável 'user'
user="$1"
passwd="$2"
export user
export passwd

# Executar comandos via SSH, usando IP atribuido ao arquivo ip_OK.txt
for IP in $(cat ip_OK.txt); do
    ./ssh-keyscan.sh "$IP" &>>/dev/null
    echo "$IP"
    sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no "$user"@"$IP" \
        "
        # cmd
        source /Zanthus/Zeus/pdvJava/EMUL.INI  &>>/dev/null
        echo ""$passwd"" | sudo -S sed -i "s/FW_FLAGS="${FW_FLAGS}"/FW_FLAGS=2/" /Zanthus/Zeus/pdvJava/EMUL.INI
        echo ""$passwd"" | sudo -S sed -i "s/FW_MODELO_IMPRESSORA="${FW_MODELO_IMPRESSORA}"/FW_MODELO_IMPRESSORA=0/" /Zanthus/Zeus/pdvJava/EMUL.INI
        echo ""$passwd"" | sudo -S rm -rf /opt/pdv_e1update &>>/dev/null
        echo ""
        cat /Zanthus/Zeus/pdvJava/ECFRECEB.CFG
        cat /Zanthus/Zeus/pdvJava/EMUL.INI
        echo "..."
        # cmd
        "
done
