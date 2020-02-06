#!/bin/bash
GRAFANA_PORT=$(kubectl -n openfaas get svc grafana -o jsonpath="{.spec.ports[0].port}")

# Install Grafana if not installed yet and expose it
if [ -z $GRAFANA_PORT ]; then
    kubectl -n openfaas run \
        --image=stefanprodan/faas-grafana:4.6.3 \
        --port=3000 \
        grafana

    kubectl -n openfaas expose deployment grafana \
    --type=NodePort \
    --name=grafana

    GRAFANA_PORT=$(kubectl -n openfaas get svc grafana -o jsonpath="{.spec.ports[0].port}")
fi

# Expose grafana via port-forward
GRAFANA_LOCAL_PORT=31113
RUNNING=$(ps aux | grep "[k]ubectl port-forward -n openfaas svc/grafana $GRAFANA_LOCAL_PORT:3000")
if [[ -z $RUNNING ]]; then
    kubectl port-forward -n openfaas svc/grafana $GRAFANA_LOCAL_PORT:3000 > /dev/null &
fi

GRAFANA_URL=http://$IP_ADDRESS:$GRAFANA_LOCAL_PORT/dashboard/db/openfaas
