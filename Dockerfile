FROM golang:1.20

RUN apt-get update && apt-get install -y openssl

WORKDIR /app
COPY . .

RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/private/key.pem -out /etc/ssl/certs/cert.pem -days 365 -nodes \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"

RUN go mod tidy
RUN go build -o go-forward-proxy .

CMD ["./go-forward-proxy"]