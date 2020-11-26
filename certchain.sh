#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

mkdir -p certs/ca/
pushd certs/ca/

##############################
# RootCA                     #
##############################

openssl genrsa -out root-ca.key 2048

openssl req -new -key root-ca.key \
            -subj '/C=CC/ST=ST/O=OO/CN=RootCA' \
            -out root-ca.csr

openssl x509 -req -in root-ca.csr -signkey root-ca.key -out root-ca.crt -days 36500 -sha256

##############################
# IntermediateCA             #
##############################

openssl genrsa -out intermediate-ca.key 2048

openssl req -new -key intermediate-ca.key \
            -subj '/C=CC/ST=ST/O=OO/CN=IntermediateCA' \
            -out intermediate-ca.csr

openssl x509 -req -in intermediate-ca.csr -CA root-ca.crt -CAkey root-ca.key -CAcreateserial -out intermediate-ca.crt -days 36500 -sha256 \
             -extfile ca.config -extensions ca

##############################
# localhost                  #
##############################

popd
pushd certs/

openssl genrsa -out localhost.key 2048

openssl req -new -key localhost.key \
            -subj '/C=CC/ST=ST/O=OO/CN=localhost' \
            -out localhost.csr

openssl x509 -req -in localhost.csr -CA ca/intermediate-ca.crt -CAkey ca/intermediate-ca.key -CAcreateserial -out localhost.crt -days 36500 -sha256

##############################
# cleanup                    #
##############################

rm -rf ca/*.srl *.srl ca/*.csr *.csr
