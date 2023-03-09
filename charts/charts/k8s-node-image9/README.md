# K8S Node Image

The k8s-node-image chart provides a a standalone image useful for installing
bare metal nodes that can form a k8s cluster.

This can be used in conjunction with pixiecore and dhcpd.

## Dependencies

This chart requires nginx-ingress 0.22.0 or higher in the default config. To
support older nginx-ingress, set ingress.regex=false.

For other ingress controllers, you will need to annotate as needed to get
rewriting to happen appropriately for your ingress controller.

## Install Chart

To install the Chart into your Kubernetes cluster :

```bash
helm install --namespace "k8s-node-image" pnnl-miscscripts/k8s-node-image
```

After installation succeeds, you can get a status of Chart

```bash
helm status <release>
```

If you want to delete your Chart, use this command:

```bash
helm delete  --purge <release>
```

