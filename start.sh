#!/bin/bash

export IP_ADDRESS=127.0.0.1
export OPENFAAS_URL=$IP_ADDRESS:31112

echo "In order to take advantage of the env-variables set, source this file"

# Start OpenFaaS via k3d
k3d start -a # very "experimental" :)

sh ./run-gateway.sh > /dev/null &

source ./run-grafana.sh