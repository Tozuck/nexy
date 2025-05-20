#!/bin/bash

echo_info() {
  echo -e "\033[1;32m[INFO]\033[0m $1"
}
echo_error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
  exit 1
}

apt-get update; apt-get install curl socat git nload speedtest-cli -y

if ! command -v docker &> /dev/null; then
  curl -fsSL https://get.docker.com | sh || echo_error "Docker installation failed."
else
  echo_info "Docker is already installed."
fi

rm -r Marzban-node

git clone https://github.com/Gozargah/Marzban-node

rm -r /var/lib/marzban-node

mkdir /var/lib/marzban-node

rm ~/Marzban-node/docker-compose.yml

cat <<EOL > ~/Marzban-node/docker-compose.yml
services:
  marzban-node:
    image: gozargah/marzban-node:latest
    restart: always
    network_mode: host
    environment:
      SSL_CERT_FILE: "/var/lib/marzban-node/ssl_cert.pem"
      SSL_KEY_FILE: "/var/lib/marzban-node/ssl_key.pem"
      SSL_CLIENT_CERT_FILE: "/var/lib/marzban-node/ssl_client_cert.pem"
      SERVICE_PROTOCOL: "rest"
    volumes:
      - /var/lib/marzban-node:/var/lib/marzban-node
EOL
curl -sSL https://raw.githubusercontent.com/Tozuck/Node_monitoring/main/node_monitor.sh | bash
rm /var/lib/marzban-node/ssl_client_cert.pem

cat <<EOL > /var/lib/marzban-node/ssl_client_cert.pem
-----BEGIN CERTIFICATE-----
MIIEnDCCAoQCAQAwDQYJKoZIhvcNAQENBQAwEzERMA8GA1UEAwwIR296YXJnYWgw
IBcNMjUwNTIwMjA0NjEyWhgPMjEyNTA0MjYyMDQ2MTJaMBMxETAPBgNVBAMMCEdv
emFyZ2FoMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAlQ62im5efUAn
qz9Z8EWIykOGyXzaLwalHM7Mb6te3jU5QxUHtVRH/ZR/kWN7DlyUIgcUyP2ouO4C
4K+wx+n0RmlL80FTsXyg6bUvWqEjfWDIr6TgN2XGBn9n7FdeAi4zzy1PHXLw+muR
M5f0RJf8itzeT7LpGBB3r3r3AZoHj2hIk4O7c1nm4sujhxoYmciPV/valQY2J/i5
t2PrC4yMdXZukCl9BXX4mmy/HmlYhGEZ94yUtZgNYPq3oJIx6K9SvzR1+edRuhYg
/FCZvo3yfay3pemwLuipg+2grdbOdUfTkdF7zKLNAddSlI84TKoUNHH5gfNKqPJX
MGy4p29TbrTTTO1msR3cA5ZzaO/vGEvVXU6p+2UwX9tmV1Dw9ZFWns7PqRUSm431
JyVNQ77u5vet5GijCR5b0kAv0Mbd/hfEuoO95joeSFNoxbu3TcN/BZjUUZPrqCUl
5T0mK2kC2dYvgOOkzKV+9weZWP/JsHgR0S5Dhg6eDjhKPG5GXXYig2TG74fohB8y
7c+t7ljCIh0VfaYqrwntyHBpf/+y7Bku0bPMOdB06pi0VjMY6JWElANO/favVQxO
PtT9Kwy9dmiga6bs0Sf994z0+Oh+wgsoVDLRrZhe4Qwx56b38cbEyc4/bdIYA1Bq
58kOdvCGaQB7/qBXY0eQIUYQw66p5FsCAwEAATANBgkqhkiG9w0BAQ0FAAOCAgEA
XX/qCSar9uTYiGvch7TxJERRmOdBdmutF4KR1pjP+dhnsQKSfqZzACk5W9yfcFL9
P8S7iNAwSGTwfsObdF7iY+IvCd01e0OGdfMzVTFcuDvTNtMHJF3GC/BpYDKQP0zG
s5OWkH9+8mTQpuWIOOX5NDQY1dWL/ldVXGrxZqfmEu4Py9RFOZaNrNcKB9OjyS5j
Rq4/pfpzJvuEK3Fcj4WcgrqyqxlI/i/OANAPD3gkBqvWxGlqvF7c3yf653OtgZN+
9wjF7TQROAIYHE0YQrTODypJtKjD3c4WLs0FdZ1JGfYNvI5X0Yvc+PbcLEV1i1wt
kq0z5dihKUzKaT7SOAT4yoxlXRJacLPNSqkRUzSWIIYVoRH7687dWw81/XffkqqN
IFV86inrngafcHcxmtQQCFGFQtu2zc3amyjh5sDC2yfb8qYYEnwjqf87a/a5a4aJ
vfv8YPWAAag2XRSyTy0Ph/Dd3nMepk1EsPwf6e4yxD1ZCMOTaIalqnYXuusz21Kc
2HEGVrrtm5a5cslH7cskpISp8o4P9zP8QwBNrC8eT/g88MFi8GZOV3htVmAGmh78
NCy5esq3VpOLi9hakMCqQ2TnuAy77A+kioglaYfTBk2dPJAN2BAicPgHq7IsHswJ
5C9zIuY22nbz96jCDaXWSKon0XwfNnWV6RPmDhUEryY=
-----END CERTIFICATE-----
EOL

cd ~/Marzban-node
docker compose up -d


