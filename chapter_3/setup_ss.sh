#!/bin/bash

sudo apt update
sudo apt install -y docker.io

cat > /var/tmp/ss-config.json <<EOF
{
    "server": "0.0.0.0",
    "server_port": 8388,
    "local_port": 1080,
    "password": "${password}",
    "timeout": 600,
    "method": "chacha20-ietf-poly1305",
    "fast_open": true
}
EOF

sudo docker run \
    -v /var/tmp:/var/tmp \
    -e ARGS='-c /var/tmp/ss-config.json' \
    -p 8388:8388 \
    -p 8388:8388/udp \
    -d \
    shadowsocks/shadowsocks-libev
