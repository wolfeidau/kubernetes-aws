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

BUILD_NO=1

aws cloudformation create-stack \
  --stack-name "kubernetes-vpc-dev-${BUILD_NO}" \
  --template-body "file://./kubernetes-multi-az-vpc.json" \
  --capabilities CAPABILITY_IAM \
  --parameters $PARAMS
