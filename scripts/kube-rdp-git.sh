#!/bin/sh
if [ $# -lt 1 ]; then
    echo usage: kube-rdp-git.sh [kube_namespace]
    exit 1
fi

ENV=$1
FILES="$(git diff --name-only)"

for file in $FILES
do
    kube-redeploy ${ENV} ${file}
done