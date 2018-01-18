#!/bin/sh
if [ $# -lt 2 ]; then
    echo usage: kube-redeploy.sh [kube_namespace] [kube_file]
    exit 1
fi

ENV=$1
FILE=$2

kubectl -n${ENV} delete -f ${FILE}
kubectl -n${ENV} create -f ${FILE}
