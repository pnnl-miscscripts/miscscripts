# Chronyd

The chronyd chart launches chronyd on each node of the cluster.


## Install Chart

To install the Chart into your Kubernetes cluster :

```bash
kubectl create namespace chronyd
helm upgrade --install --namespace "chronyd" chronyd pnnl-miscscripts/chronyd -f chronyd-values.yaml
```

After installation succeeds, you can get a status of Chart

```bash
helm status "chronyd"
```

If you want to delete your Chart, use this command:

```bash
helm delete  --purge "chronyd"
```

### Chronyd configuration
Set your chronyd config like:
```yaml
config: |
  pool pool.ntp.org iburst maxsources 3
  rtcsync
  driftfile /var/lib/chrony/drift
```

