#!/bin/bash

# Subjects
COUNTRY="RU"
STATE="Home"
LOCALITY="Home"
ORGANIZATION="HomeLab"
FQDN="traefik.homeleb.local"
IP="192.168.1.76"

# Генерация закрытого ключа для root CA
# openssl genrsa -des3 -out rootCA.key 4096

# Генерация самоподписанного сертификата для root CA
# openssl req -x509 -new -nodes -key rootCA.key -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/CN=RootCA" -sha256 -days 3650 -out rootCA.crt

# Генерация закрытого ключа и сертификата для FQDN
openssl req -new -nodes -newkey rsa:4096 -keyout "$FQDN".key -out "$FQDN".csr -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/CN=$FQDN"

# Подпись сертификата для FQDN с использованием root CA
openssl x509 -req -in "$FQDN".csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out "$FQDN".pem -sha256 \
    -extfile <(printf "subjectAltName=DNS:$FQDN,IP:$IP")

# Верификация сертификата
openssl verify -CAfile rootCA.crt "$FQDN".pem
