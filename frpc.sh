#!/bin/bash

FRPC_INI=~/frpc.ini

case $1 in
    init)
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Usage: $0 init <IP> <TOKEN>"
            exit 1
        fi
        SERVER_ADDR=$2
        TOKEN=$3
        cat <<EOF >$FRPC_INI
[common]
server_addr = $SERVER_ADDR
server_port = 17000
token = $TOKEN
[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 8000
EOF
        ;;
    start)
        frpc -c $FRPC_INI
        ;;
    *)
        echo "Usage: $0 {init|start}"
        exit 1
        ;;
esac
