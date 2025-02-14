# Go Forward Proxy

A simple Go-based forward proxy that redirects incoming HTTP requests to a specified destination URL.

## Features

- Supports HTTPS forwarding with self-signed certificates.
- Customizable target URL via environment variables.
- Dockerized deployment with `docker-compose`.
- Automated SSL certificate generation if missing.

## Installation & Usage

### 1. Run with Docker

```sh
# Build and run the container
docker-compose up --build -d
```

### 2. Run without Docker

Ensure you have Go installed, then:

```sh
go mod tidy
go build -o go-forward-proxy .
./go-forward-proxy
```

## Configuration

The proxy can be configured via environment variables:

- `TARGET_URL`: The destination URL to which requests will be forwarded.

## Docker Setup

### `Dockerfile`

- Uses `golang:1.23` as the base image.
- Installs OpenSSL and CA certificates.
- Builds the Go binary and ensures execution permissions.
- Uses an `entrypoint.sh` script to handle SSL certificate generation dynamically.

### `entrypoint.sh`

This script checks for existing SSL certificates and generates new ones if missing.

### `docker-compose.yml`

Defines a service `proxy` that:

- Builds the image from the Dockerfile.
- Exposes port `2020` mapped to the application's internal port `1010`.
- Uses `TARGET_URL` as an environment variable.

## Example Request

Once the proxy is running, you can test it by sending a request:

```sh
curl -k https://localhost:2020
```

## License

This project is licensed under the MIT License.