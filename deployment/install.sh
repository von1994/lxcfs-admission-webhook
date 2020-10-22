#!/bin/bash

NAMESPACE=kube-system

./deployment/webhook-create-signed-cert.sh --namespace ${NAMESPACE}
kubectl get secret lxcfs-admission-webhook-certs -n ${NAMESPACE}

kubectl create -f deployment/deployment.yaml -n ${NAMESPACE}
kubectl create -f deployment/service.yaml -n ${NAMESPACE}
cat ./deployment/mutatingwebhook.yaml | ./deployment/webhook-patch-ca-bundle.sh > ./deployment/mutatingwebhook-ca-bundle.yaml
kubectl create -f deployment/mutatingwebhook-ca-bundle.yaml -n ${NAMESPACE}

