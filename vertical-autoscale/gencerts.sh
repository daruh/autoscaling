#!/bin/bash

# Copyright 2018 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Generates the a CA cert, a server key, and a server cert signed by the CA.
# reference:
# https://github.com/kubernetes/kubernetes/blob/master/plugin/pkg/admission/webhook/gencerts.sh
set -o errexit
set -o nounset
set -o pipefail

BACK="${PWD}"
CN_BASE="vpa_webhook"
TMP_DIR="/tmp/vpa-certs"

echo "Generating certs for the VPA Admission Controller in ${TMP_DIR}."
mkdir -p ${TMP_DIR}
cd 
cat > server.conf << EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, serverAuth
subjectAltName = DNS:vpa-webhook.kube-system.svc
EOF

# Create a certificate authority
openssl genrsa -out caKey.pem 2048
set +o errexit
openssl req -x509 -new -nodes -key caKey.pem -days 100000 -out caCert.pem -subj "/CN=${CN_BASE}_ca" -addext "subjectAltName = DNS:${CN_BASE}_ca"
if [[ $? -ne 0 ]]; then
  echo "ERROR: Failed to create CA certificate for self-signing. If the error is \"unknown option -addext\", update your openssl version or deploy VPA from the vpa-release-0.8 branch."
  exit 1
fi
set -o errexit

# Create a server certificate
openssl genrsa -out serverKey.pem 2048
# Note the CN is the DNS name of the service of the webhook.
openssl req -new -key serverKey.pem -out server.csr -subj "/CN=vpa-webhook.kube-system.svc" -config server.conf -addext "subjectAltName = DNS:vpa-webhook.kube-system.svc"
openssl x509 -req -in server.csr -CA caCert.pem -CAkey caKey.pem -CAcreateserial -out serverCert.pem -days 100000 -extensions SAN -extensions v3_req -extfile server.conf

echo "Uploading certs to the cluster."
kubectl create secret --namespace=kube-system generic vpa-tls-certs --from-file=caKey.pem --from-file=caCert.pem --from-file=serverKey.pem --from-file=serverCert.pem

# Clean up after we're done.
echo "Deleting ${TMP_DIR}."
rm -rf ${TMP_DIR}

cd "${BACK}"