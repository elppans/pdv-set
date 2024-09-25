#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root."
  exit 1
fi

# Atualiza a lista de pacotes
echo "Atualizando a lista de pacotes..."
apt update

# Instala o pacote de fusos horários, se necessário
echo "Instalando o pacote de fusos horários..."
apt install -y tzdata

# Define o fuso horário, altere 'America/Sao_Paulo' se necessário
echo "Definindo o fuso horário para America/Sao_Paulo..."
timedatectl set-timezone America/Sao_Paulo

# Ativa a atualização automática do horário de verão
echo "Habilitando a atualização automática do horário de verão..."
timedatectl set-ntp true

# Mostra a configuração atual
echo "Configuração atual de data e hora:"
timedatectl

echo "Atualização do horário de verão concluída."