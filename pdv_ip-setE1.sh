#!/bin/bash

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
# shellcheck disable=SC2013
for IP in $(cat ip_OK.txt); do

    echo "$IP" &&
        sshpass -p "$passwd" ssh -o StrictHostKeyChecking=no "$user"@"$IP" \
            "
source /etc/environment
echo ""$passwd"" | sudo -S $Z_MOUNT 2>/dev/null
mount | grep path
echo ""$passwd"" | sudo -S find /Zanthus -name ECFRECEB.CFG 
# echo ""$passwd"" | sudo -S rm -rfv /Zanthus/Zeus/path_comum_temp/GERALCFG/ECFRECEB.CFG 2>/dev/null
# echo ""$passwd"" | sudo -S rm -rfv /Zanthus/Zeus/path_comum/GERALCFG/ECFRECEB.CFG 2>/dev/null
# echo ""$passwd"" | sudo -S rm -rfv /Zanthus/Zeus/path_comum_servidor/GERALCFG/ECFRECEB.CFG 2>/dev/null
# echo ""$passwd"" | sudo -S rm -rfv /Zanthus/Zeus/path_comum_servidor/ZArqConfig/ECFRECEB.CFG 2>/dev/null
# echo ""$passwd"" | sudo -S rm -rfv /Zanthus/Zeus/path_comum_servidor/ZArqConfig64/ECFRECEB.CFG 2>/dev/null
# Procurar e remover com find em /Zanthus o arquivo ECFRECEB.CFG mantendo o do diretório /Zanthus/Zeus/pdvJava
# Procurar e remover também, ECFRECEB.CFG.OLD
echo ""$passwd"" | sudo -S find /Zanthus -path /Zanthus/Zeus/pdvJava -prune -o \( -name "ECFRECEB.CFG" -o -name "ECFRECEB.CFG.OLD" \) -exec rm {} \; 2>/dev/null
echo ""$passwd"" | sudo -S rm -rf /opt/pdv_e1update 2> /dev/null
echo ""$passwd"" | sudo -S git clone https://github.com/elppans/pdv_elgini9x64.git /opt/pdv_e1update
cd /opt/pdv_e1update
echo ""$passwd"" | sudo -S ./set_elgini9x64.sh
grep VERSION_ID /etc/os-release
grep biblioteca /Zanthus/Zeus/pdvJava/ECFRECEB.CFG
cat /Zanthus/Zeus/pdvJava/EMUL.INI
ls -l /Zanthus/Zeus/lib_u64/libE1_Impressora*
echo ""
echo ""$passwd"" | date | sudo -S tee /Zanthus/Zeus/update.txt 
"
done
