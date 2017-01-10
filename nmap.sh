#!/bin/bash

function check_ip_port()
{
    ip=$1
    port=$2
    nmap -p$port $ip | awk '/'$port'/{print $2}'
}

check_ip_port 127.0.0.1 9098
