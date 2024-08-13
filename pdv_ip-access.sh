#!/bin/bash

ipssh="$1"
sshpass -p zanthus ssh -o StrictHostKeyChecking=no user@"$ipssh"

