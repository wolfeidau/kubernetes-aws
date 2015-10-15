#!/bin/bash -euo pipefail

build_parameters() {
  for k in "$@" ; do
    key=$(echo $k | cut -f1 -d=)
    value=${k#*$key=}
    printf "ParameterKey=%s,ParameterValue=%s " $key ${value//,/\\,}
  done
}

if [[ $# -lt 3 ]] ; then
  echo "usage: $0 [... Key=Val]"
  exit 1
fi

# grab the org slug to generate the provision bucket default
if [[ "$*" =~ ClusterSize=([0-9]+) ]]; then
  CLUSTER_SIZE=${BASH_REMATCH[1]}
elif [[ -z $CLUSTER_SIZE ]]; then
  echo "Must provide either a ClusterSize parameter or set a CLUSTER_SIZE env"
  exit 1
fi

BUILD_NO=1
STACK_TEMPLATE="./cloudformation/kubernetes-etcd.json"
DISCO_URL=$(curl -s https://discovery.etcd.io/new?size=${CLUSTER_SIZE})
PARAMS=$(build_parameters "$@")
PARAMS+=" ParameterKey=ClusterSize,ParameterValue=$CLUSTER_SIZE"
PARAMS+=" ParameterKey=DiscoveryURL,ParameterValue=$DISCO_URL"

aws cloudformation create-stack \
  --stack-name "kubernetes-etcd-dev-${BUILD_NO}" \
  --template-body "file://${STACK_TEMPLATE}" \
  --capabilities CAPABILITY_IAM \
  --parameters $PARAMS
