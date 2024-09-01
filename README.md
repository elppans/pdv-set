# pdv-set
___
## Observação:

Código retirado e simplificado de `pdv-ssync`, porém, não é e nem fará parte do mesmo.  
Este pacote é utilizado exclusivamente à configuração padrão à distância, de acordo com a documentação.  
Qualquer aspecto FORA da documentação NÃO será implementada.  
___

- Dependência

```ini
sshpass
```

- Instalando  

```bash
cd /opt
git clone https://github.com/elppans/pdv-set.git && cd pdv-set
```
- Edite o arquivo ip.txt

O arquivo deve ser criado e editado em `$HOME/.ip`  

- Execute os comandos.

```bash
pdv-set_ping.sh # Teste de comunicação
pdv-set_Elgini9E1.sh # Configura Elgin i9 padrão nos IPs fornecidos em ip*.txt
pdv-set_version.sh # Exibe a configuração atual dos PDVs nos IPs fornecidos em ip*.txt
```