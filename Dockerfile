FROM golang:1.23

RUN apt-get update && apt-get install -y openssl ca-certificates

RUN mkdir -p /etc/ssl/private && touch /etc/ssl/openssl.cnf

WORKDIR /app
COPY . .

# Build the Go binary
RUN go mod tidy
RUN go build -o go-forward-proxy .

# Ensure the binary is executable
RUN chmod +x /app/go-forward-proxy

# List files in /app to verify the binary is there
RUN ls -al /app

CMD ["/app/entrypoint.sh"]