// The proxy will redirect incoming requests to another destination URL.
// This server will accept HTTP requests and forward them to the destination site, returning the result back to the client.

package main

// ProxyHandler handles the HTTP requests by forwarding them to the destination.

import (
	"crypto/tls"
	"fmt"               // For Console output
	"log"               // For logging error messages
	"net/http"          // For creating an HTTP server
	"net/http/httputil" // For forwarding HTTP requests via proxy
	"net/url"           // For processing URLs
)

func ProxyHandler(w http.ResponseWriter, r *http.Request) {
	// Specify the target address want to proxy
	// target := "https://anitsayac.com/"
	target := "http://go.com/"

	// Parsing the URL
	parsedURL, err := url.Parse(target)
	if err != nil {
		http.Error(w, "Could not parse target URL", http.StatusInternalServerError)
		return
	}
	customTransport := &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}

	// Create
	proxy := httputil.NewSingleHostReverseProxy(parsedURL)

	proxy.Transport = customTransport

	// Direct the incoming HTTP request to the target server
	proxy.ServeHTTP(w, r)
}

func main() {
	// Direct all HTTP requests coming to the server to the ProxyHandler function.
	http.HandleFunc("/", ProxyHandler)
	port := "1010"

	fmt.Println("Starting proxy server on port", port)

	err := http.ListenAndServeTLS(":"+port, "/etc/ssl/certs/cert.pem", "/etc/ssl/private/key.pem", nil)
	if err != nil {
		log.Fatal("Error starting the server: ", err)
	}
}
