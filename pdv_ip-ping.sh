#!/bin/bash

rm -rf ip_OK.txt >> /dev/null
rm -rf ip_OFF.txt >> /dev/null

# shellcheck disable=SC2013
for IP in $(cat ip.txt); do
    ping -c 1 "$IP" >>/dev/null &&
        echo "$IP" >> ip_OK.txt ||
        echo "$IP OFF" >> ip_OFF.txt
done
