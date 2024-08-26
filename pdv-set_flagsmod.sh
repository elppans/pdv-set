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
# Variáveis para o ambiente de PDV
ecfreceb="/Zanthus/Zeus/pdvJava/ECFRECEB.CFG"
emul="/Zanthus/Zeus/pdvJava/EMUL.INI"
lib_u64="/Zanthus/Zeus/lib_u64"
busdev="$(lsusb | grep '20d1:7008' | awk '{print $6}')"

# Exportar variáveis para o ambiente
export ecfreceb
export emul
export lib_u64
export busdev

# Exportar environments
source "$ecfreceb" &>>/dev/null
source "$emul" &>>/dev/null

# Verifica se IRQ = i9
if [ "$busdev" == "20d1:7008" ]; then
# Se IRQ for igual de Elgin i9, faz as configurações necessárias.
    echo "Elgin i9"
    # Verifica se IZ != R82 e configura
    if [ ! "$ecfreceb" == "izrcb_R82" ]; then
    # Se IZ != R82 faz a conversão.
        # echo "Configurando IZ para R82..."
        # echo -e 'biblioteca=izrcb_R82\n' >"$ecfreceb"
        # echo "Configurando EMUL.INI..."
        # # Verifica se o parâmetro FW_INVERTE_GAVETA já existe e não está comentado
        # if grep -q "^[^#]*FW_INVERTE_GAVETA" "$emul"; then
        #     # Adiciona as configurações necessárias com o parâmetro FW_INVERTE_GAVETA
        #     {
        #         echo -e 'FW_FLAGS=1'
        #         echo -e 'FW_MODELO_IMPRESSORA=0'
        #         echo -e 'FW_PORTA_USB'
        #         echo -e 'FW_INVERTE_GAVETA'
        #     } >"$emul"
        # else
        #     # Adiciona as configurações necessárias
        #     {
        #         echo -e 'FW_FLAGS=2'
        #         echo -e 'FW_MODELO_IMPRESSORA=0'
        #         echo -e 'FW_PORTA_USB'
        #     } >"$emul"
        # fi
        :
    else
    # Se IZ = R82 faz alumas correções, se necessário
        if grep -q "^[^#]*FW_INVERTE_GAVETA" "$emul"; then
            # Adiciona as configurações necessárias com o parâmetro FW_INVERTE_GAVETA
			# cmd
            # echo ""$passwd"" | sudo -S sed -i "s/FW_FLAGS="${FW_FLAGS}"/FW_FLAGS=1/" "$emul"
            echo ""$passwd"" | sudo -S sed -i "s/FW_MODELO_IMPRESSORA="${FW_MODELO_IMPRESSORA}"/FW_MODELO_IMPRESSORA=0/" "$emul"
            echo " "
            grep 'FW_FLAGS' "$emul"
            grep 'FW_MODELO_IMPRESSORA' "$emul"
			# cmd
        else
            # Adiciona as configurações necessárias quando SEM o parâmetro FW_INVERTE_GAVETA
            # cmd
            # echo ""$passwd"" | sudo -S sed -i "s/FW_FLAGS="${FW_FLAGS}"/FW_FLAGS=2/" "$emul"
            echo ""$passwd"" | sudo -S sed -i "s/FW_MODELO_IMPRESSORA="${FW_MODELO_IMPRESSORA}"/FW_MODELO_IMPRESSORA=0/" "$emul"
            echo " "
            grep 'FW_FLAGS' "$emul"
            grep 'FW_MODELO_IMPRESSORA' "$emul"
			# cmd
        fi
    fi
else
# Se IRQ for diferente de Elgin i9, NÃO faz nada!
    :
fi
        # Shell/CMD
        "
done
