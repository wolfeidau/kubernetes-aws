# kubernetes-multi-az

This cloudformation setup uses the "Layer cake".

The `kubernetes-multi-az-vpc.json` template will provision the following:

* VPC to host kubernetes
* Public a and b subnets
* Internet Gateway
* Private a and b subnets

# software configuration

Need to setup a certificate authority using the `internal domain name`.

Need to generate certificates for:

* etcd
* api server
* client
