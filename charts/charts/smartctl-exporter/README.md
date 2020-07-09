# smartctl-exporter

The smartctl-exporter chart launches smartctl-exporter on each node of the cluster.


## Install Chart

To install the Chart into your Kubernetes cluster:

```bash
kubectl create namespace smartctl-exporter
helm upgrade --install --namespace "smartctl-exporter" smartctl-exporter pnnl-miscscripts/smartctl-exporter -f smartctl-exporter-values.yaml
```

After installation succeeds, you can get a status of Chart

```bash
helm status "smartctl-exporter"
```

If you want to delete your Chart, use this command:

```bash
helm delete "smartctl-exporter"
```

### Chronyd configuration
Set your smartctl-exporter config like:
```yaml
config:
  devices:
  - /dev/sda
  - /dev/sdb
```

