#!/bin/bash
RUNNING=$(ps aux | grep "[k]ubectl port-forward -n openfaas svc/gateway 31112:8080")
if [[ -z $RUNNING ]]; then
    kubectl port-forward -n openfaas svc/gateway 31112:8080
fi