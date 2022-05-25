#!/bin/bash -e

kubectl "${1:-get}" \
    -f resource-manifests/multicloud/coit-config-map.yaml \
    -f resource-manifests/multicloud/coit-backend1-deployment.yaml \
    -f resource-manifests/multicloud/coit-backend2-deployment.yaml \
    -f resource-manifests/multicloud/coit-frontend-deployment.yaml \
    -f resource-manifests/multicloud/service-coit-backend1-lb.yaml \
    -f resource-manifests/multicloud/service-coit-backend2.yaml \
    -f resource-manifests/multicloud/service-coit-frontend-lb.yaml \
    -f resource-manifests/multicloud/hpa-coit-frontend.yaml \
    -f resource-manifests/multicloud/ingress-coit-frontend.yaml
