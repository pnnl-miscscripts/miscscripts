# ipmi-exporter chart

This chart allows you to deploy the ipmi exporter.

## Install Chart

To install the Chart into your Kubernetes cluster:

```bash
helm install --namespace prometheus --name "ipmi-exporter" pnnl-miscscripts/ipmi-exporter"
```

After installation succeeds, you can get a status of Chart

```bash
helm status "ipmi-exporter"
```

If you want to delete your Chart, use this command:

```bash
helm delete  "ipmi-expoerter"
```

## Configuration
set the value config: with any configuration as described here:
https://github.com/soundcloud/ipmi_exporter#configuration

An example is provided here:
https://github.com/soundcloud/ipmi_exporter/blob/master/ipmi_remote.yml

