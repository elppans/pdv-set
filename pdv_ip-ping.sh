#!/bin/bash

rm -rf ip_OK.txt >> /dev/null
rm -rf ip_OFF.txt >> /dev/null

# shellcheck disable=SC2013
for IP in $(cat ip.txt); do
    if ping -c 1 "$IP" >>/dev/null; then
        echo "$IP" OK
        echo "$IP" >>ip_OK.txt
    else
        echo "$IP OFF"
        echo "$IP OFF" >>ip_OFF.txt
    fi
done
