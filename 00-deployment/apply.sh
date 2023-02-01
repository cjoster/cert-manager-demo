#!/usr/bin/env bash

set -euo pipefail

kubectl config set-context --current --namespace=hello-world
kubectl apply -f .
kubectl delete pods  --all
