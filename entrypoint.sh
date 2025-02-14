#!/bin/sh

CERT_PATH="/etc/ssl/certs/cert.pem"
KEY_PATH="/etc/ssl/private/key.pem"

if [ ! -f "$CERT_PATH" ] || [ ! -f "$KEY_PATH" ]; then
    echo "Cant find certificates, new certs creating..."
    openssl req -x509 -newkey rsa:4096 -keyout "$KEY_PATH" -out "$CERT_PATH" -days 365 -nodes \
        -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost" \
        -config /etc/ssl/openssl.cnf
fi

# Proxy
exec /app/go-forward-proxy