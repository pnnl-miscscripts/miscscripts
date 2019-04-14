# DHCPD

The DHCPD chart launches a simple dhcpd server for your bare metal cluster.


## Install Chart

To install the Chart into your Kubernetes cluster :

```bash
helm install --namespace "dhcpd" --name "dhcpd" pnnl-miscscripts/dhcpd -f dhcpd-values.yaml
```

After installation succeeds, you can get a status of Chart

```bash
helm status "dhcpd"
```

If you want to delete your Chart, use this command:

```bash
helm delete  --purge "dhcpd"
```

### DHCPD configuration
Set your interface(s) like:
```yaml
interfaces: ['eth0']
```

Add your subnets to the subnets list like:
```yaml
config:
  subnets:
  - start: 172.22.0.0
    netmask: 255.255.255.0
```

Setup a group and add your hosts like:
```yaml
config:
  groups:
  - domainName: example.com
    domainNameServers: [172.22.0.1]
    routers: [172.22.0.1]
    subnetMask: 255.255.255.0
    hosts:
    - name: c1
      mac: 00:01:02:aa:bb:cc
      ip: 172.22.0.3
```

