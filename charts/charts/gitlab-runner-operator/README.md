# gitlab-runner-operator

The gitlab-runner-operator chart launches an instance of the gitlab-runner-operator allowing you to quickly deploy gitlab-runners in a Kubernetes native way.


## Install Chart

Apply the CRD's if not already done so:
```bash
kubectl apply -f https://raw.githubusercontent.com/pnnl-miscscripts/miscscripts/master/containers/gitlab-runner-operator/deploy/crds/miscscripts.pnnl.gov_clustergitlabrunnerflavors_crd.yaml
kubectl apply -f https://raw.githubusercontent.com/pnnl-miscscripts/miscscripts/master/containers/gitlab-runner-operator/deploy/crds/miscscripts.pnnl.gov_gitlabrunners_crd.yaml
```

To install the Chart into your Kubernetes cluster (Helm 3 only) :

```bash
kubectl create namespace gitlab-runner-operator
helm upgrade --install gitlab-runner-operator --namespace "gitlab-runner-operator" pnnl-miscscripts/gitlab-runner-operator
```

After installation succeeds, you can get a status of Chart

```bash
helm status "gitlab-runner-operator" --namespace "gitlab-runner-operator"
```

If you want to delete your Chart, use this command:

```bash
helm delete "gitlab-runner-operator"
```

### Usage
You can create a cluster wide gitlab flavor like:
```yaml
apiVersion: miscscripts.pnnl.gov/v1beta1
kind: ClusterGitlabRunnerFlavor
metadata:
  name: example
spec:
  gitlabUrl: http://localhost:8080
  unregisterRunners: true
```

To deploy a runner, you may do so like:
```yaml
apiVersion: miscscripts.pnnl.gov/v1beta1
kind: GitlabRunner
metadata:
  name: example
spec:
  flavorRef:
    name: example
    kind: ClusterGitlabRunnerFlavor
    group: miscscripts.pnnl.gov
  runners:
    tags: foo,bar
    secret: example
```

When a flavorRef is specified, settings in the flavor are added to the Runner. The Runner config overrides the flavor config.

The content of the spec in both ClusterGitlabRunnerFlavor and GitlabRunner is values as specified here:
```
https://gitlab.com/gitlab-org/charts/gitlab-runner/blob/master/values.yaml
```

It is highly recommended that you don't include the gitlab runner token in the CR but upload it as its own secret and specify it to the GitlabRunner CR as above.
Upload the secret like:
```bash
kubectl create secret generic example --from-literal=runner-registration-token=<your token> --from-literal=runner-token=""
```
