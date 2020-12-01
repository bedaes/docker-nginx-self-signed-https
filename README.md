# Nginx Proxy with self-signed certificate

## Usage

```bash
# re-create certificates
./certchain.sh

# run nginx
./server.sh

# install root CA
sudo cp certs/ca/root-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

# try GET request using node
# npm install axios
./get.js

# check TLS connection using OpenSSL
echo | openssl s_client -showcerts -connect localhost:443

# check TLS connection using curl
curl https://localhost

# remove root CA
sudo rm /usr/local/share/ca-certificates/root-ca.crt
sudo update-ca-certificates --fresh
```

Note: This is running the container on the host network. It is required that
port 80 and 443 are not used by any other application. Also this does only work
when Docker can be ran natively. This won't work on Mac OS X and Windows.
