# kubernetes-aws

This cloudformation setup uses the "Layer cake".

The `kubernetes-multi-az-vpc.json` template will provision the following:

* VPC to host kubernetes
* Public a and b subnets
* Internet Gateway
* Private a and b subnets

```
./bin/buildvpc.sh
```

# etcd

This stack will build an etcd cluster to support kubernetes.

As illustrated below it requires some of the values outputed in the previous stack.

```
./bin/buildetcd.sh VpcId=vpc-ff95a89a SubnetPublicA=subnet-1ac7a743 SubnetPublicB=subnet-b8226dcf
```

# todo

* Build out the kubernetes controller and workers.

# warning

This is a work in progress at the moment and has some pretty basic defaults right now.

# License

kubernetes-aws is Copyright (c) 2015 Mark Wolfe @wolfeidau and licensed under the MIT license. All rights not explicitly granted in the MIT license are reserved. See the included LICENSE.md file for more details.

