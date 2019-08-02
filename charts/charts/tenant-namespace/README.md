tenant-namespace is a chart that lets you quickly provision a namespace for a
tenant

TL;DR;

First, put whatever cluster specific default values into
mycluster-tenant-namespace-values.yaml

```console
read -p 'Enter Tenant name: ' tenant
helm install namespace --name $tenant --namespace ${tenant}-admin \
  -f mycluster-tenant-namespace-values.yaml \
  --set magicnamespace.namespace=$tenant \
  --set ingress.controller.scope.namespace=$tenant
```

To get the ci secret to put into your ci system, you can do something like:
```console
kubectl get secret -n $tenant $(kubectl get serviceaccount -n $tenant ci -o go-template='{{ (index .secrets 0).name }}') -o go-template='{{ .data.token | base64decode }}{{ printf "\n" }}'
```

