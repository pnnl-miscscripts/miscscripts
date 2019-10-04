# NGINX App chart

This chart allows you to deploy a simple web application container running nginx, and provides a service and ingress to the application


## Install Chart

To install the Chart into your Kubernetes cluster :

```bash
helm install --name "mywebapp" pnnl-miscscripts/chronyd --set image.repository=nginx
```

After installation succeeds, you can get a status of Chart

```bash
helm status "mywebapp"
```

If you want to delete your Chart, use this command:

```bash
helm delete  --purge "mywebapp"
```


