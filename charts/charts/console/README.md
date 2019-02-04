# Console

The Console chart spawns a pod per console you have in your cluster.

Currently, the only driver is ipmitool.


## Install Chart

To install the Chart into your Kubernetes cluster :

```bash
helm install --namespace "console" --name "console" pnnl-miscscripts/console
```

After installation succeeds, you can get a status of Chart

```bash
helm status "console"
```

If you want to delete your Chart, use this command:

```bash
helm delete  --purge "console"
```

### Console configuration

Add your hosts to the host list like:
```yaml
hosts:
- host: p1
  ip: 192.168.1.20
  secret: ipmi
- host: p2
  ip: 192.168.1.21
  secret: ipmi
```

Where host is the name for the host. Ip is the ipmi bmc's ip or hostname. Secret is a Kubernetes secret in the same namespace with key username = ipmi username and password = ipmi password.

For example, to create a secret named ipmi that can be used with this chart:
```bash
kubectl create secret generic ipmi --namespace console --from-literal=username=ADMIN --from-literal=password=ADMIN
```

