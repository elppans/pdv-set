#!/bin/bash
# shellcheck disable=all

source /Zanthus/Zeus/pdvJava/EMUL.INI  &>>/dev/null
echo ""$passwd"" | sudo -S sed -i "s/FW_FLAGS="${FW_FLAGS}"/FW_FLAGS=2/" /Zanthus/Zeus/pdvJava/EMUL.INI
echo ""$passwd"" | sudo -S sed -i "s/FW_MODELO_IMPRESSORA="${FW_MODELO_IMPRESSORA}"/FW_MODELO_IMPRESSORA=0/" /Zanthus/Zeus/pdvJava/EMUL.INI
echo ""$passwd"" | sudo -S rm -rf /opt/pdv_e1update &>>/dev/null
echo ""
cat /Zanthus/Zeus/pdvJava/ECFRECEB.CFG
cat /Zanthus/Zeus/pdvJava/EMUL.INI
echo "..."