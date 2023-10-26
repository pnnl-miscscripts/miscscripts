# tenant-namespace-operator

The tenant-namespace-operator chart launches an instance of the tenant-namespace-operator allowing you to quickly deploy tenant-namespaces in a Kubernetes native way.


## Install Chart

Apply the CRD's if not already done so:
```bash
kubectl apply -f https://raw.githubusercontent.com/pnnl-miscscripts/miscscripts/master/containers/tenant-namespace-operator/config/crd/bases/miscscripts.pnnl.gov_tenantnamespaceflavors.yaml
kubectl apply -f https://raw.githubusercontent.com/pnnl-miscscripts/miscscripts/master/containers/tenant-namespace-operator/config/crd/bases/miscscripts.pnnl.gov_tenantnamespaces.yaml
```

To install the Chart into your Kubernetes cluster (Helm 3 only) :

```bash
kubectl create namespace tenant-namespace-operator
helm upgrade --install tenant-namespace-operator --namespace "tenant-namespace-operator" pnnl-miscscripts/tenant-namespace-operator
```

After installation succeeds, you can get a status of Chart

```bash
helm status "tenant-namespace-operator" --namespace "tenant-namespace-operator"
```

If you want to delete your Chart, use this command:

```bash
helm delete "tenant-namespace-operator"
```

### Usage
You can create a cluster wide tenantnamespace flavor like:
```yaml
apiVersion: miscscripts.pnnl.gov/v1beta1
kind: TenantNamespaceFlavor
metadata:
  name: example
spec: {}
```

To deploy a tenant namespace named example, you may do so like:
```yaml
apiVersion: miscscripts.pnnl.gov/v1beta1
kind: TenantNamespace
metadata:
  name: example
spec:
  flavorRef:
    name: example
    kind: TenantNamespaceFlavor
    group: miscscripts.pnnl.gov
```

When a flavorRef is specified, settings in the flavor are added to the TenantNamespace. The TenantNamespace config overrides the flavor config.

The content of the spec in both TenantNamespaceFlavor and TenantNamespace are values as specified here:
```
https://gitlab.com/gitlab-org/charts/tenant-namespace/blob/master/values.yaml
```
